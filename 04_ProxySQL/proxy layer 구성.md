### Proxy Layer 구성
```
    연결 폴더 구성
        리눅스 
            mkdir -p  /data/proxysql/data /data/proxysql/conf
            chmod -R 777 /data/proxysql*
        윈도우
            d:\data\proxysql\data 
            d:\data\proxysql\conf

    proxysql.cnf 생성 및 644 권한을 준다.
        proxysql.cnf  참조

    컨테이너 생성
        docker run -it --name proxysql -h proxysql \ 
        -p 6032:6032 -p 6033:6033 \
        --net mybridge --net-alias=proxysql \
        -v d:\data\proxysql\data:/var/lib/proxysql \
        -v d:\data\proxysql\conf\proxysql.cnf:/etc/proxysql.cnf \
        -d proxysql/proxysql

        docker ps --format "table {{.ID}} \t {{.Names}} \t {{.Status}}"

    ProxySQL 접속
        docker exec -it proxysql /bin/bas

        호스트 PC 에서 접속 
        mysql -h127.0.0.1 -p6032 - uradmin -pradmin --prompt "ProxySQL Admin>" 
```

### Failover 테스트
```
    docker exec -it -uroot db001 /bin/bash

    mysql -uroot -p
        create database testdb default character set utf8;
        
        create user 'appuser'@'%' identified by 'apppass';
        grant select , insert, update, delete on testdb.* to appuser@'%';

        create user 'monitor'@'%' identified by 'apppass';
        grant select , insert, update, delete on testdb.* to appuser@'%';


```
