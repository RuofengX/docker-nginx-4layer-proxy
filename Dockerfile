FROM alpine:latest

LABEL maintainer="WeiRuofeng <weiruofeng@ruofengx.cn>"


ENV TZ=Asia/Shanghai
RUN set -ex \
	## install dependence
	&& sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories \
	&& apk add -U \
	## add timezone support
	&& apk add tzdata \
	&& apk add nginx nginx-mod-stream
	
COPY nginx/stream.d/ /etc/nginx/stream.d
RUN echo "" > /etc/nginx/http.d/default.conf \
    && echo "include /etc/nginx/stream.conf;" >> /etc/nginx/nginx.conf

CMD ["nginx"]