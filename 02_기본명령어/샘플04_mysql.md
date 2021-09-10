### mysql 생성 샘플
```
    데이터 경로를 먼저 생성한다. 
    mkdir d:\data\db\db001\data d:\data\db\db001\log d:\data\db\db001\conf

    d:/data/confs/db001/mysql.cnf  로 저장 한다. 
    [mysqld]
    log_bin                     = mysql-bin
    binlog_format               = ROW
    gtid_mode                   = ON
    enforce-gtid-consistency    = true
    server-id                   = 100
    log_slave_updates
    datadir                     = /var/lib/mysql
    socket                      = /var/lib/mysql/mysql.sock

    # Disabling symbolic-links is recommended to prevent assorted security risks
    symbolic-links              = 0

    log-error                   = /var/log/mysql/mysqld.log
    pid-file                    = /var/run/mysqld/mysqld.pid

    report_host                 = db001

    [mysqld_safe]
    pid-file                    = /var/run/mysqld/mysqld.pid
    socket                      = /var/lib/mysql/mysql.sock
    nice                        = 0


    docker run -it --name db001 -h db001 -p 3307:3306 \
    --net mybridge --net-alias=db001 \
    -v d:\data\db\db001\data:/var/lib/mysql \
    -v d:\data\db\db001\log:/var/log/mysql \
    -v d:\data\db\db001\conf:/etc/percona-server.conf.d \
    -e MYSQL_ROOT_PASSWORD="root" \
    -d percona:5.7.30    
```