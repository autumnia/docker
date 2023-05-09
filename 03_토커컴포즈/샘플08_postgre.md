Dockerfile 내용
  FROM rust:latest
  
  WORKDIR /app/
  
  COPY . .
  
  RUN rustup default
  
  RUN cargo install diesel_cli --no-default-features --features postgres
  RUN cargo install cargo-watch

  CMD ["cargo", "watc", "--why", "--", "echo"]
 
 ---------------------------------------------------------
 
 docker-compose.yml 내용
 
