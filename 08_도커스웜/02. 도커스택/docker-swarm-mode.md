### docker stack in swarm mode

```
    bridge network => overlay network  사용

    필요한 디렉토리 생성
    tree -d
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

    cd  <= root or 계정 폴더로 이동됨
    mkdir swarm-mode
    cd swarm-mode
    docker-compose.yml 생성
    post_script.sh 생성

    docker stack deploy -c docker-compose.yml mysql   <= 실행 시간이 걸림

    docker stack ls
    docker stack ps mysql
    docker service ls

    post_script.sh

    다른 노드에서도 같이 실행 시킴
    docker service ps mysql_db001
    docker ps --format "table {{.ID}} \t {{.Names}} \t {{.Status}}"
    
    docker exec {{containerID}} sh /opt/exporters/node_exporter/start_node_exporter.sh
    docker exec {{containerID}} sh /opt/exporters/mysqld_exporter/start_mysqld_exporter.sh
    
    웹콘솔 확인
        오케스트레이터
        그라파나


```