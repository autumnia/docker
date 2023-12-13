# docker-compose.xml
```
version: "3"

services:
  mongodb:
    image: mongo:4.4
    restart: always
    container_name: mongodb
    ports:
      - "27017:27017"
    environment:
      MONGO_INITDB_ROOT_USERNAME: root
      MONGO_INITDB_ROOT_PASSWORD: 12345678 
    volumes:
      - mongodb_datas:/data/db
volumes:
  mongodb_datas:
```

# collection 생성 / 조회
```
  // database 변경
  use('testdb')
  // collection 생성
  db.createCollection('book')
  // 데이터 입력
  db.book.insertOne({name:"hello mongo", author:"choi"})
  db.book.insertMany([{name:"hello java", author:"kim"}, {name:"hello docker", author:"lee"}])
  // 데이터 조회
  db.book.find().pretty()
  // 데이터 업데이트
  db.book.updateOne( { _id: ObjectId("61e374779cbbcefe0d6d744d") }, { $set: { author: "lee docker" } } )
  // 업데이트 데이터 조회
  db.book.find({name:"hello docker"})
  // 데이터 삭제
  db.book.deleteOne({name:"hello docker"})
```
