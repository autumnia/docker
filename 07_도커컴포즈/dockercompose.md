### Docker compose 설치  ( 리눅스일 경우에 한함 윈도우는 자동 설치 됨 )
```
    curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o //usr/local/bin/docker-compose

    권한 추가 
        chmod +x /usr/local/bin/docker-compose

    설치 후 버전 확인
        docker-compose -v
```

### 구성실행
```
    실행 전 상태 조회
        docker ps --format "table {{.Names}} \t {{.Status}}"        

    docker-compose.yml 작성 후 실행
        docker-compose up -d

    실행 후 상태 조회
        docker ps --format "table {{.Names}} \t {{.Status}}"

    구성 자동화를 위한 스크립트 작성 ==> 권한 설정 ==> 실행 
        chmod +x post_script.sh
        ./post_script.sh

```

