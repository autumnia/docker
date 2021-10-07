# grafana 생성 샘플
```
    ## 도커 실행
    docker run -it --name grafana -h grafana -p 3000:3000 \
    --net mybridge --net-alias=grafana \
    -d grafana/grafana

    http://{docker_host_ip}:3000     admin / admin
        configuration > data sources > prometheus 선택
        url: http://prometheus:9090

    https://github.com/percona/grafana-dashboards/tree/master/dashboards
    https://github.com/percona/grafana-dashboards/blob/master/dashboards/MySQL_Overview.json

    mysql 모니터링시 
    + > create 메뉴 >  import에서 MySQL_Overview.json 파일을 가져온다. 

```


