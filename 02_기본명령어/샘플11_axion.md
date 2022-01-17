# 도커에 Axion 설치
```
    네트워크 구성이 필요없을 경우 만들지 않는다.
    
    docker network ls   <= 기본 4개
    docker network create --driver bridge springbankNet```


    docker run -d --name axon-server \
    -p 8024:8024 -p 8124:8124 \
    --network springbankNet \
    --restart always axoniq/axonserver:latest
```