### 젠킨스 생성 샘플
```
    nginx 실행
    docker run --name nginx01 -h nginx01 -p 80:80 -p 443:443\
    -v d:\data\nginx\html:/usr/share/nginx/html \
    -v d:\data\nginx\config\nginx.conf:/etc/nginx/conf.d/nginx.conf \
    -d nginx:latest
```

```

# nginx.conf 파일
# 컨테이너 내부에 /etc/nginx/conf.d/nginx.conf 경로에 존재

user  nginx;
worker_processes  1;

error_log  /var/log/nginx/error.log warn;
pid        /var/run/nginx.pid;


events {
    worker_connections  1024;
}


http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile        on;
    #tcp_nopush     on;

    keepalive_timeout  65;

    #gzip  on;

    include /etc/nginx/conf.d/*.conf;

    #security
    server_tokens off;
}

```