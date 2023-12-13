# docker-compose.yml

version: '3.7'
services:
  redis:
    image: redis:7.0.4
    command: redis-server --port 6379
    container_name: redis_standalone
    hostname: redis_standalone
    labels:
      - "name=redis"
      - "mode=standalone"
    ports:
      - 6379:6379

# 테스트 및 사용법
--------------------------------------
```rust
  ## 레디스 접속
  >> docker exec -it redis_boot redis-cli

  ## 접속 테스트 
  127.0.0.1:6379> PING
  PONG
  127.0.0.1:6379> keys *
  (empty array)
  127.0.0.1:6379> SET abc 123
  OK
  127.0.0.1:6379> GET abc
  "123"
  127.0.0.1:6379>
```
