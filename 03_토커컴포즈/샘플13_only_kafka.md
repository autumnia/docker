# kafka dev install
```rust
  version: "3"
  services:
    kafka:
      image: 'bitnami/kafka:latest'
      volumes:
        - my-vol:/app/myapp
      ports:
        - '9092:9092'
      environment:
        - KAFKA_ENABLE_KRAFT=yes
        - KAFKA_CFG_PROCESS_ROLES=broker,controller
        - KAFKA_CFG_CONTROLLER_LISTENER_NAMES=CONTROLLER
        - KAFKA_CFG_LISTENERS=PLAINTEXT://:9092,CONTROLLER://:9093
        - KAFKA_CFG_LISTENER_SECURITY_PROTOCOL_MAP=CONTROLLER:PLAINTEXT,PLAINTEXT:PLAINTEXT
        - KAFKA_CFG_ADVERTISED_LISTENERS=PLAINTEXT://127.0.0.1:9092
        - KAFKA_BROKER_ID=1
        - KAFKA_CFG_CONTROLLER_QUORUM_VOTERS=1@127.0.0.1:9093
        - ALLOW_PLAINTEXT_LISTENER=yes
  volumes:
    my-vol:
      external: true
```

# kafka cluster install
```rust
version: '3'
services:
  kafka1:
    image: confluentinc/cp-kafka:7.2.1
    container_name: kafka1
    environment:
      KAFKA_NODE_ID: 1
      KAFKA_LISTENER_SECURITY_PROTOCOL_MAP: CONTROLLER:PLAINTEXT,PLAINTEXT:PLAINTEXT
      KAFKA_LISTENERS: PLAINTEXT://kafka1:9092,CONTROLLER://kafka1:9093
      KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://kafka1:9092
      KAFKA_CONTROLLER_LISTENER_NAMES: 'CONTROLLER'
      KAFKA_CONTROLLER_QUORUM_VOTERS: '1@kafka1:9093,2@kafka2:9093,3@kafka3:9093'
      KAFKA_PROCESS_ROLES: 'broker,controller'
    volumes:
      - ./run_workaround.sh:/tmp/run_workaround.sh
    command: "bash -c '/tmp/run_workaround.sh && /etc/confluent/docker/run'"

  kafka2:
    image: confluentinc/cp-kafka:7.2.1
    container_name: kafka2
    environment:
      KAFKA_NODE_ID: 2
      KAFKA_LISTENER_SECURITY_PROTOCOL_MAP: CONTROLLER:PLAINTEXT,PLAINTEXT:PLAINTEXT
      KAFKA_LISTENERS: PLAINTEXT://kafka2:9092,CONTROLLER://kafka2:9093
      KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://kafka2:9092
      KAFKA_CONTROLLER_LISTENER_NAMES: 'CONTROLLER'
      KAFKA_CONTROLLER_QUORUM_VOTERS: '1@kafka1:9093,2@kafka2:9093,3@kafka3:9093'
      KAFKA_PROCESS_ROLES: 'broker,controller'
    volumes:
      - ./run_workaround.sh:/tmp/run_workaround.sh
    command: "bash -c '/tmp/run_workaround.sh && /etc/confluent/docker/run'"

  kafka3:
    image: confluentinc/cp-kafka:7.2.1
    container_name: kafka3
    environment:
      KAFKA_NODE_ID: 3
      KAFKA_LISTENER_SECURITY_PROTOCOL_MAP: CONTROLLER:PLAINTEXT,PLAINTEXT:PLAINTEXT
      KAFKA_LISTENERS: PLAINTEXT://kafka3:9092,CONTROLLER://kafka3:9093
      KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://kafka3:9092
      KAFKA_CONTROLLER_LISTENER_NAMES: 'CONTROLLER'
      KAFKA_CONTROLLER_QUORUM_VOTERS: '1@kafka1:9093,2@kafka2:9093,3@kafka3:9093'
      KAFKA_PROCESS_ROLES: 'broker,controller'
    volumes:
      - ./run_workaround.sh:/tmp/run_workaround.sh
    command: "bash -c '/tmp/run_workaround.sh && /etc/confluent/docker/run'"
```
