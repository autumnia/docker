# docker-compose.yml
```
version: '3.7'

services:
  mariadb:
    image: mariadb
    container_name: mariadb
    ports:
        - 3306:3306
    restart: always
    volumes:
        - mariadb:/var/lib/mysql
    environment:
      MARIADB_ROOT_PASSWORD: 12345678
      
volumes:
    mariadb:
```

# 데이터베이스 사용자 생성
```
-- 데이터 베이스 확인
SHOW DATABASES;

-- 데이터 베이스 생성
CREATE DATABASE 데이터베이스명;

-- 데이터 베이스 확인
SHOW DATABASES;

-- mysql database 를 사용
USE mysql;

-- root 패스워드 변경
UPDATE user SET password=password('변경할비번')
WHERE user = 'root';

UPDATE user SET plugin='mysql_native_password'
WHERE user='root';
-- 10.4 이상은 아래 명령어로 실행
set password = password('변경할비번');
-- 새로고침
FLUSH PRIVILEGES;

-- 사용자 확인
SELECT HOST, USER, PASSWORD FROM USER;

-- 사용자 계정 생성 'id'@'localhost' 이면 로컬에서만 접속 가능
CREATE USER '아이디'@'%' IDENTIFIED BY '비밀번호';

-- 사용자 권한 주기
GRANT ALL PRIVILEGES ON 데이터베이스.* TO '아이디'@'%';

-- 새로고침
FLUSH PRIVILEGES;

-- 사용자 계정 삭제 '사용자'@'접속위치'
DROP USER [사용자]@[서버];
-- 예) DROP USER testUser@localhost;
```
