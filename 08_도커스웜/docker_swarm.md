###
```
    확장성
        1. Scale Up
        2. Scale Out  <= Docker Swarm

    swarm mode 구성
        ![docker_swarm_mode]](./docker_swarm_mode.png)
        docker swarm init --adverties-addr { manager_noe_ip }
        위 명령어를 실행하면 워커노드 추가를 위한 토큰과 명령어가 출력된다. 

    swarm mode cluster 시작
        필요한 포트 
            swarm manager 기본 포트 2377
            추가포트  7946, 4789  <= TCP, UDP 모두 오픈 필요함

        Worker Node 추가 ( 1, 2번 장비에서 각각 수행 필요함 )
            docker swarm join --token 토큰  { manager_noe_ip }:2377

        Node 확인
            docker node ls
            
    Custom image 사용
        custom image 등록  ==> docker hub 계정 생성 후 로그인 필요함
        아래 명령어로 로그인 

        docker login
            username:
            password:

        이미지 올리기
            docker images
            docker tag mysql57:0.0  autumnia/mysql57:0.0
            docker push autumnia/mysql57:0.0

        기존 컨테이너 초기화
            docker ps
            rm -rf /data/db/*

        swarm의 경우 서비스 단위로 실행
            docker service create --name db001 --hostname db001 -p 3306:3306 \
            --mount type=bind, source=/db/db001/data, target=/var/lib/mysql \
            --mount type=bind, source=/db/db001/log,  target=/var/log/mysql \
            --mount type=bind, source=/db/db001/conf, target=/etc/percona-server.conf.d \
            -e MYSQL_ROOT_PASSWORD="root" --with-registry-auth \
            autumnia/mysql57:0.0

    서비스 확인 ( 매니저 노드에서만 조회 )
        docker service ls
        dockeer service ps db001

    해당 노드에서 확인 할 경우 
        docker ps --format "table {{.Names}} \t {{.Status}}"
    
    Mysql 서비스 접속 확인 
        1. manager node ip로 접속 확인
            mysql -uroot -p -h {manager_node_ip}

        2. worker node ip로 접속 확인
            mysql -uroot -p -h {worker_node_ip}

    데이터 유지 방법 ( 해당 container가 특정 노드에서만 실행 되도록 한다. )
        1.  Label을 이용한 방법
            docker service rm db001
            docker service ls

            docker node ls
            docker node update --label-add server_name=db001
            
            모든 노드에 mysql group & user 생성
            groupadd -g 1001 mysql
            useradd -u 1001 -r -g 1001 mysql

            첫번째 worker Node에서 디렉토리 생성
            mkdir -p /db/db001/data /db/db001/log /db/db001/conf
            vi /db/db001/conf/my.cnf  <==  05 custom dockerfile 참조
            chown -R mysql:mysql /db

            서비스 재생성
            docker service create --name db001 --hostname db001 -p 3306:3306 \
            --mount type=bind, source=/db/db001/data, target=/var/lib/mysql \
            --mount type=bind, source=/db/db001/log,  target=/var/log/mysql \
            --mount type=bind, source=/db/db001/conf, target=/etc/percona-server.conf.d \
            -e MYSQL_ROOT_PASSWORD="root" --with-registry-auth \
            --constraint 'node.labels.server_name==db001' \
            autumnia/mysql57:0.0

            서비스 생성 확인
            docker service ls
            docker service ps db001

            해당 노드에 가서 
            docker ps
            docker stop  아이디
            docker service ps db001

        2. NFS Storage mount


        3. Volume plugin ( GlusterFS )    
```