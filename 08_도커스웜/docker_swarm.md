###
```
    확장성
        1. Scale Up
        2. Scale Out  <= Docker Swarm


    swarm mode 구성
        ![docker_swarm_mode]](./docker_swarm_mode.png)
        docker swarm init --adverties-addr { manager_noe_ip }

    swarm mode cluster 시작
        필요한 포트 
            swarm manager 기본 포트 2377
            추가포트  7946, 4789  <= TCP, UDP 모두 오픈 필요함

        Worker Node 추가 ( 1, 2번 장비에서 각각 수행 필요함 )
            docker swarm join --token 토큰  { manager_noe_ip }:2377

        Node 확인
            docker node ls
            

```