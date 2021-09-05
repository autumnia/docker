### docker stack in swarm mode

```
    bridge network => overlay network  사용

    필요한 디렉토리 생성
    mkdir -p /db/db001 /db/db001/data /db/db001/log /db/db001/conf
    mkdir -p /db/db002 /db/db002/data /db/db002/log /db/db001/conf
    mkdir -p /db/db003 /db/db003/data /db/db003/log /db/db001/conf

    chown -R mysql:mysql /db/db001 /db/db002 /db/db003

    mkdir -p /db/rpm001 /db/rpm001/data /db/rpm001/conf

    mkdir -p /db/proxysql /db/proxysql/data /db/proxysql/conf

    파일생성
    my.cnf
    prometheus.yml
    proxysql.cnf 
```