### mysql 생성 샘플
```
    docker run -it --name db001 -h db001 -p 3307:3306 \
    --net mybridge --net-alias=db001 \
    -v d:\data\db\db001\data:/var/lib/mysql \
    -v d:\data\db\db001\log:/var/log/mysql \
    -v d:\data\db\db001\conf:/etc/percona-server.conf.d \
    -e MYSQL_ROOT_PASSWORD="root" \
    -d percona:5.7.30

```