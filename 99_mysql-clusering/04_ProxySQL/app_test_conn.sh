#!/bin/bash
while true;
do

  mysql -uappuser -papppass -h172.31.10.19 -P6033 -N -e "select @@hostname,now()" 2>&1| grep -v "Warning"

  sleep 1

done
