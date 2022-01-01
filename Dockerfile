FROM alpine:latest

LABEL maintainer="WeiRuofeng <weiruofeng@ruofengx.cn>"

COPY nginx/conf.d/ /etc/nginx/conf.d

ENV TZ=Asia/Shanghai
RUN set -ex \
	## install dependence
	&& sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories \
	&& apk add -U \
	## add timezone support
	&& apk add tzdata \
	&& apk add nginx
	