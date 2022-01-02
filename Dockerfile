FROM ubuntu:latest AS nginx-stream
LABEL maintainer="WeiRuofeng <weiruofeng@ruofengx.cn>"


ENV TZ=Asia/Shanghai
RUN set -ex \
	## install dependence
	&& sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list \
    && sed -i s@/security.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list \
    && apt update && apt upgrade -y \
	&& apt install -y wget libpcre3-dev build-essential libssl-dev zlib1g-dev \
    && apt clean \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /opt
RUN wget https://nginx.org/download/nginx-1.21.5.tar.gz \
    && tar -zxvf nginx-1.*.tar.gz \
    && cd nginx-1.* \
    && ./configure --prefix=/opt/nginx --user=nginx --group=nginx --with-threads --with-stream \
    && make -j $(nproc) && make install \
    && cd .. && rm -rf nginx-1.*

####################################################

FROM ubuntu:latest AS prod

COPY --from=nginx-stream /opt/nginx /opt/nginx

# nginx user
RUN adduser --system --no-create-home --disabled-login --disabled-password --group nginx

ADD nginx.conf /opt/nginx/conf/nginx.conf

WORKDIR /

EXPOSE 25565

CMD ["/opt/nginx/sbin/nginx"]