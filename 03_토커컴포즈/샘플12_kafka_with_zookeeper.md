# docker-compose.xml
```
version: '2'
services:
  zookeeper:
    image: wurstmeister/zookeeper
    container_name: zookeeper
    ports:
      - "2181:2181"
  kafka:
    image: wurstmeister/kafka
    container_name: kafka
    ports:
      - "9092:9092"
    environment:
      KAFKA_ADVERTISED_HOST_NAME: 127.0.0.1
      KAFKA_ZOOKEEPER_CONNECT: zookeeper:2181
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
```

# 설치 확인
```
토픽 생성하기
$ kafka-topics.sh --create --topic board_topic --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1

생성된 토픽확인
$ kafka-topics.sh --describe --topic board_topic --bootstrap-server kafka:9092

$ cd /opt/kafka_2.13-2.8.1/bin/

컨슈머 실행하기
$ ./kafka-console-consumer.sh --topic board_topic --bootstrap-server kafka:9092

프로듀서 실행하기
$ ./kafka-console-producer.sh --topic board_topic --broker-list kafka:9092

컨슈머 결과 보기
```
