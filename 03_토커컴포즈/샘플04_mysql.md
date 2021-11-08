### 네트워크 조회 및 생성
```
  $ sudo docker network ls   
  $ sudo docker network create --driver bridge mybridge
```

### docker-compose.yml  파일 작성 후 저장
version: "3"

services:
  mysql:
    image: percona:5.7.30 
    container_name: mysql

    hostname: mysql
    ports:
      - "3306:3306"

    environment:
      - MYSQL_ROOT_PASSWORD="root"

    user: root

    volumes:
      - D:\gitroot\data\db:/var/lib/mysql
      - D:\gitroot\data\db\log:/var/log/mysql
      - D:\gitroot\data\db\conf:/etc/percona-server.conf.d

    networks:
      - mybridge


### 실행 및 접속
```
  docker-compose up -d 
```      