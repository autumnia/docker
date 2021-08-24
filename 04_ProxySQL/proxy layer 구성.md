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

#### db001 설정
```   
    docker exec -it -uroot db001 /bin/bash

    mysql -uroot -p
        create database testdb default character set utf8;
        
        create user appuser@'%' identified by 'apppass';
        grant select , insert, update, delete on testdb.* to appuser@'%';

        create user 'monitor'@'%' identified by 'monitor';
        grant replication client on *.*  to 'monitor'@'%';

        flush privileges;
    exit
```

#### proxysql 테스트 환경 구성
```
    mysql -h127.0.0.1 -p6032 -uradmin -pradmin --prompt "ProxySQL Admin>"
        # 서버등록
        insert into mysql_servers( hostgroup_id, hostname, port) values ( 10, 'db001', 3306 );

        insert into mysql_servers( hostgroup_id, hostname, port) values ( 20, 'db001', 3306 );
        insert into mysql_servers( hostgroup_id, hostname, port) values ( 20, 'db002', 3306 );
        insert into mysql_servers( hostgroup_id, hostname, port) values ( 20, 'db003', 3306 );
        insert into mysql_replication_hostgroups values(10, 20, 'read_only', '');

        load mysql servers to runtime;
        save mysql servers to disk;

        # 사용자 등록
        insert into mysql_users( username, password, default_hostgroup, transaction_persistent)
        values( 'appuser', 'apppass', 10, 0 );

        load mysql users to runtime;
        save mysql users to disk;        

        # 룰 등록
        insert into mysql_query_rules( rule_id, active, match_pattern, destination_hostgroup)
        values( 1, 1, '^select.*for update$', 10 );

        insert into mysql_query_rules( rule_id, active, match_pattern, destination_hostgroup)
        values(2, 1, '^select', 20)

        load mysql rules to runtime;
        save mysql rules to disk;   

    exit
    
```

#### write 환경 구축
```
    docker exec -it -uroot db001 /bin/bash
    mysql -uroot -p

        use testdb;
        database changed

        create table insert_test(
            hostname varchar(5) not null,
            insert_time datetime not null
        )

        sh app_test_insert.sh
```

#### 테스트 구성
    truncate table testdb.insert_test;
    sh app_test_insert.sh


    






