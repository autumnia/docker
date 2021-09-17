# prometheus 생성 샘플
```
    ## 도커 실행
    docker run -it --name prom001 -h prom001 -p 9090:9090 \
    --net mybridge --net-alias=prom001 \
    -v d:\data\prome001\data:/data \
    -v d:\data\prome001\conf:/etc/prometheus \
    -d prom/prometheus-linux-amd64

```


