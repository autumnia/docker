Dockerfile 내용

  FROM rust:latest
  
  WORKDIR /app/
  
  COPY . .
  
  RUN rustup default
  
  RUN cargo install diesel_cli --no-default-features --features postgres
  RUN cargo install cargo-watch

  CMD ["cargo", "watc", "--why", "--", "echo"]
 
 ---------------------------------------------------------
 
# docker-compose.yml 내용
 
 version: '3.3'
 
 service:
  postgres:
    image: postgres:latest
    environment:
      - POSTGRES_USER=autumnia
      - POSTGRES_PASSWORD=autumn
      - POSTGRES_DB=app_db
    command: ["postgres", "-c", "log_statement=all]
    
   redis:
    image: redis:latest
    
   app:
    build: .
    environment:
      - DTABASE_URL=postgres://autumnia:autumn@postgres/app_db
    ports:
      - 8000:8000
    volumes:
      - ./:/app
 
----------------------------------------------
실행
 docker-compose up -d

 docker-compose build

 docker-compose ps
 
 docker-compose logs postgre
 
