# KRaft kafka
```rust
  version: "3"
  services:
    kafka1:
        image: confluentinc/cp-kafka:7.3.3
        hostname: kafka1
        container_name: kafka1
        ports:
          - "39092:39092"
        environment:
          KAFKA_LISTENERS: BROKER://kafka1:19092,EXTERNAL://kafka1:39092,CONTROLLER://kafka1:9093
          KAFKA_ADVERTISED_LISTENERS: BROKER://kafka1:19092,EXTERNAL://kafka1:39092
          KAFKA_INTER_BROKER_LISTENER_NAME: BROKER
          KAFKA_CONTROLLER_LISTENER_NAMES: CONTROLLER
          KAFKA_LISTENER_SECURITY_PROTOCOL_MAP: CONTROLLER:PLAINTEXT,BROKER:PLAINTEXT,EXTERNAL:PLAINTEXT
          KAFKA_PROCESS_ROLES: 'controller,broker'
          KAFKA_NODE_ID: 1
          KAFKA_CONTROLLER_QUORUM_VOTERS: '1@kafka1:9093,2@kafka2:9093,3@kafka3:9093'
          KAFKA_LOG_DIRS: '/app/kafka_logs'
        volumes:
          - /app/kafka_data
          #- ./scripts/update_run.sh:/tmp/update_run.sh
          #- ./clusterID:/tmp/clusterID
        #command: "bash -c '/tmp/update_run.sh && /etc/confluent/docker/run'"

    kafka-gen:
      image: confluentinc/cp-kafka:7.3.3
      hostname: kafka-gen
      container_name: kafka-gen
      volumes:
        /app/kafka_data:
      #  - ./scripts/create_cluster_id.sh:/tmp/create_cluster_id.sh
      #  - ./clusterID:/tmp/clusterID
      #command: "bash -c '/tmp/create_cluster_id.sh'"
```

# kafka dev install
```rust
  version: "3"
  services:
    kafka:
      image: 'bitnami/kafka:latest'
      hostname: dev_kafka
      volumes:
        - /app/kafka_data:/app/myapp
      ports:
        - '9092:9092'
        - '9093:9093'
        - '9094:9094'
      environment:
        - KAFKA_ENABLE_KRAFT=yes
        - KAFKA_CFG_PROCESS_ROLES=broker,controller
        - KAFKA_CFG_CONTROLLER_LISTENER_NAMES=CONTROLLER
        - KAFKA_CFG_LISTENERS=PLAINTEXT://:9092,CONTROLLER://:9093,EXTERNAL://:9094
        - KAFKA_CFG_LISTENER_SECURITY_PROTOCOL_MAP=CONTROLLER:PLAINTEXT,PLAINTEXT:PLAINTEXT,EXTERNAL:PLAINTEXT
        - KAFKA_CFG_ADVERTISED_LISTENERS=PLAINTEXT://127.0.0.1:9092,EXTERNAL://app/kafka_data:9094
        - KAFKA_BROKER_ID=1
        - KAFKA_CFG_CONTROLLER_QUORUM_VOTERS=1@127.0.0.1:9093
        - ALLOW_PLAINTEXT_LISTENER=yes
        - KAFKA_CFG_NODE_ID=1
        - KAFKA_AUTO_CREATE_TOPICS_ENABLE=true
        - KAFKA_CFG_NUM_PARTITIONS=2
  volumes:
    /app/kafka_data:
  networks:
    default:
      name: my-network
      external: true
```

# kafka cluster install 1
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

# kafka cluster  KRaft mode with schema-registry as a client.
```rust
version: '3'
services:
  kafka1:
    image: confluentinc/cp-kafka
    container_name: kafka1
    hostname: kafka1
    ports:
      - "9092:9092"
    environment:
      KAFKA_NODE_ID: 1
      KAFKA_CONTROLLER_LISTENER_NAMES: 'CONTROLLER'
      KAFKA_LISTENER_SECURITY_PROTOCOL_MAP: 'CONTROLLER:PLAINTEXT,INTERNAL:PLAINTEXT,EXTERNAL:PLAINTEXT'
      KAFKA_LISTENERS: 'INTERNAL://kafka1:29092,CONTROLLER://kafka1:29093,EXTERNAL://0.0.0.0:9092'
      KAFKA_ADVERTISED_LISTENERS: 'INTERNAL://kafka1:29092,EXTERNAL://localhost:9092'
      KAFKA_INTER_BROKER_LISTENER_NAME: 'INTERNAL'
      KAFKA_CONTROLLER_QUORUM_VOTERS: '1@kafka1:29093,2@kafka2:29093,3@kafka3:29093'
      KAFKA_PROCESS_ROLES: 'broker,controller'
      KAFKA_GROUP_INITIAL_REBALANCE_DELAY_MS: 0
      KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR: 3
      KAFKA_TRANSACTION_STATE_LOG_REPLICATION_FACTOR: 3
      CLUSTER_ID: 'ciWo7IWazngRchmPES6q5A=='
      KAFKA_LOG_DIRS: '/tmp/kraft-combined-logs'

  kafka2:
    image: confluentinc/cp-kafka
    container_name: kafka2
    hostname: kafka2
    ports:
      - "9093:9093"
    environment:
      KAFKA_NODE_ID: 2
      KAFKA_CONTROLLER_LISTENER_NAMES: 'CONTROLLER'
      KAFKA_LISTENER_SECURITY_PROTOCOL_MAP: 'CONTROLLER:PLAINTEXT,INTERNAL:PLAINTEXT,EXTERNAL:PLAINTEXT'
      KAFKA_LISTENERS: 'INTERNAL://kafka2:29092,CONTROLLER://kafka2:29093,EXTERNAL://0.0.0.0:9093'
      KAFKA_ADVERTISED_LISTENERS: 'INTERNAL://kafka2:29092,EXTERNAL://localhost:9093'
      KAFKA_INTER_BROKER_LISTENER_NAME: 'INTERNAL'
      KAFKA_CONTROLLER_QUORUM_VOTERS: '1@kafka1:29093,2@kafka2:29093,3@kafka3:29093'
      KAFKA_PROCESS_ROLES: 'broker,controller'
      KAFKA_GROUP_INITIAL_REBALANCE_DELAY_MS: 0
      KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR: 3
      KAFKA_TRANSACTION_STATE_LOG_REPLICATION_FACTOR: 3
      CLUSTER_ID: 'ciWo7IWazngRchmPES6q5A=='
      KAFKA_LOG_DIRS: '/tmp/kraft-combined-logs'

  kafka3:
    image: confluentinc/cp-kafka
    container_name: kafka3
    hostname: kafka3
    ports:
      - "9094:9094"
    environment:
      KAFKA_NODE_ID: 3
      KAFKA_CONTROLLER_LISTENER_NAMES: 'CONTROLLER'
      KAFKA_LISTENER_SECURITY_PROTOCOL_MAP: 'CONTROLLER:PLAINTEXT,INTERNAL:PLAINTEXT,EXTERNAL:PLAINTEXT'
      KAFKA_LISTENERS: 'INTERNAL://kafka3:29092,CONTROLLER://kafka3:29093,EXTERNAL://0.0.0.0:9094'
      KAFKA_ADVERTISED_LISTENERS: 'INTERNAL://kafka3:29092,EXTERNAL://localhost:9094'
      KAFKA_INTER_BROKER_LISTENER_NAME: 'INTERNAL'
      KAFKA_CONTROLLER_QUORUM_VOTERS: '1@kafka1:29093,2@kafka2:29093,3@kafka3:29093'
      KAFKA_PROCESS_ROLES: 'broker,controller'
      KAFKA_GROUP_INITIAL_REBALANCE_DELAY_MS: 0
      KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR: 3
      KAFKA_TRANSACTION_STATE_LOG_REPLICATION_FACTOR: 3
      CLUSTER_ID: 'ciWo7IWazngRchmPES6q5A=='
      KAFKA_LOG_DIRS: '/tmp/kraft-combined-logs'

  schema-registry:
    image: confluentinc/cp-schema-registry
    container_name: schema-registry
    hostname: schema-registry
    ports:
      - "8081:8081"
    environment:
      SCHEMA_REGISTRY_HOST_NAME: schema-registry
      SCHEMA_REGISTRY_KAFKASTORE_BOOTSTRAP_SERVERS: 'kafka1:29092,kafka2:29092,kafka3:29092'
      SCHEMA_REGISTRY_LISTENERS: 'http://0.0.0.0:8081'
    depends_on:
      - kafka1
      - kafka2
      - kafka3

networks:
  default:
    name: my-network
    external: true
```
