# rabbitmq 생성 샘플
```
    ## 도커 실행
    docker run -it --name rabbitmq -h rabbitmq \
    -p 15672:15672 -p 5672:5672 -p 15671:15671 -p 5671:5671 -p 4369:4369 \ 
    -e RABBITMQ_DEFAULT_USER=guest -e RABBITMQ_DEFAULT_PASS=guest \
    --network ecommerce-network \
    //--net ecommerce-network --net-alias=rabbitmq
    -d rabbitmq:management

    ## 주소접속
    http://127.0.0.1:15672     접속 후 guest / guest 로 접속

```