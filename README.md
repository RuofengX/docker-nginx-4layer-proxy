# docker-nginx-4layer-proxy
使用Docker和Nginx、nginx stream module制作的4层反代镜像。
An 4 layer proxy running in docker using nginx with stream module  

## 使用方法 Usage
1. 编写nginx.conf，必须是完整配置文件，可以参考nginx.example.conf，放置在根目录中。  
Write your own nginx.conf, must be a full config, place it in root folder. Example file is nginx.example.conf.

2. 运行`docker-compose up -d --build`  
Run `docker-compose up -d --build`
