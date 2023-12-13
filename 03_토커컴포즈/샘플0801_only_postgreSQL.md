# docker-compose.xml
```
version: '3.7'

services:
  postgres:
    image: postgres:latest
    container_name: postgres
    restart: always
    ports:
      - "5432:5432"
    environment:
      POSTGRES_USER: "${DB_USER_ID}"
      POSTGRES_PASSWORD: "${DB_USER_PASSWORD}"
    volumes:
      - postgres_datas:/var/lib/postgresql/data
volumes:
    postgres_datas:

### 다른 버전
version: "3.9"

services:
  db:
    image: postgres:13-alpine
    deploy:
      placement:
        constraints:
          - node.role==manager
        max_replicas_per_node: 1
    environment:
      TZ: Asia/Seoul
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD_FILE: /run/secrets/db_password
    healthcheck:
      test: ["CMD", "pg_isready", "-U", "postgres"]
    networks:
      - backend
    ports:
      - "5432:5432"
    restart: unless-stopped
    secrets:
      - db_password
    volumes:
      - ./db/initdb.d:/docker-entrypoint-initdb.d:ro
      - db_data:/var/lib/postgresql/data
networks:
  backend:
secrets:
  db_password:
    file: ./db/password.txt
volumes:
  db_data:


```

# .env
```
DB_USER_ID=postgres
DB_USER_PASSWORD=12345678
```
