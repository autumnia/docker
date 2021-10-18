# prometheus 생성 샘플
```
    ## 도커 실행
    docker run -it --name gitlab -h gitlab.example.com -p 80:80 -p 22:22 \
    --restart always \
    -v /var/gitlab/config:/etc/gitlab \
    -v /var/gitlab/logs:/var/log/gitlab \
    -v /var/gitlab/data:/var/opt/gitlab \
    -d gitlab/gitlab-ce:latest
```


