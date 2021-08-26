### Docker compose 설치  ( 리눅스일 경우에 한함 윈도우는 자동 설치 됨 )
```
    curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o //usr/local/bin/docker-compose

    권한 추가 
        chmod +x /usr/local/bin/docker-compose

    설치 후 버전 확인
        docker-compose -v
```

