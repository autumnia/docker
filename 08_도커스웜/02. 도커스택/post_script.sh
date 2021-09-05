MASTER_NODE='mysql_db001'
SLAVE01_NODE='mysql_db002'
SLAVE02_NODE='mysql_db003'
NODE_IP='172.31.10.19'

EXEC_MASTER="mysql -uroot -proot -h ${NODE_IP} -P3306 -e "
EXEC_SLAVE01="mysql -uroot -proot -h ${NODE_IP} -P3307 -e "
EXEC_SLAVE02="mysql -uroot -proot -h ${NODE_IP} -P3308 -e "

## For Replication
${EXEC_MASTER} "CREATE USER 'repl'@'%' IDENTIFIED BY 'repl'" 2>&1 | grep -v "Using a password"
${EXEC_MASTER} "GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%'" 2>&1 | grep -v "Using a password"

${EXEC_SLAVE01} "reset master" 2>&1 | grep -v "Using a password"
${EXEC_SLAVE01} "CHANGE MASTER TO MASTER_HOST='${MASTER_NODE}', \
MASTER_USER='repl', MASTER_PASSWORD='repl', \
MASTER_AUTO_POSITION=1" 2>&1 | grep -v "Using a password"
${EXEC_SLAVE01} "START SLAVE" 2>&1 | grep -v "Using a password"

${EXEC_SLAVE02} "reset master" 2>&1 | grep -v "Using a password"
${EXEC_SLAVE02} "CHANGE MASTER TO MASTER_HOST='${MASTER_NODE}', \
MASTER_USER='repl', MASTER_PASSWORD='repl', \
MASTER_AUTO_POSITION=1" 2>&1 | grep -v "Using a password"
${EXEC_SLAVE02} "START SLAVE" 2>&1 | grep -v "Using a password"

## For Orchestrator
${EXEC_MASTER} "CREATE USER orc_client_user@'%' IDENTIFIED BY 'orc_client_password'" 2>&1 | grep -v "Using a password"
${EXEC_MASTER} "GRANT SUPER, PROCESS, REPLICATION SLAVE, RELOAD ON *.* TO orc_client_user@'%'" 2>&1 | grep -v "Using a password"
${EXEC_MASTER} "GRANT SELECT ON mysql.slave_master_info TO orc_client_user@'%'" 2>&1 | grep -v "Using a password"

## For Prometheus
${EXEC_MASTER} "CREATE USER 'exporter'@'localhost' IDENTIFIED BY 'exporter123' WITH MAX_USER_CONNECTIONS 3" 2>&1 | grep -v "Using a password"
${EXEC_MASTER} "GRANT PROCESS, REPLICATION CLIENT, SELECT ON *.* TO 'exporter'@'localhost'" 2>&1 | grep -v "Using a password"

## For ProxySQL
EXEC_PROXY="mysql -h127.0.0.1 -P16032 -uradmin -pradmin -e "

${EXEC_PROXY} "INSERT INTO mysql_servers(hostgroup_id, hostname, port) VALUES (10, 'db001', 3306)" 2>&1 | grep -v "Using a password"
${EXEC_PROXY} "INSERT INTO mysql_servers(hostgroup_id, hostname, port) VALUES (20, 'db001', 3306)" 2>&1 | grep -v "Using a password"
${EXEC_PROXY} "INSERT INTO mysql_servers(hostgroup_id, hostname, port) VALUES (20, 'db002', 3306)" 2>&1 | grep -v "Using a password"
${EXEC_PROXY} "INSERT INTO mysql_servers(hostgroup_id, hostname, port) VALUES (20, 'db003', 3306)" 2>&1 | grep -v "Using a password"
${EXEC_PROXY} "INSERT INTO mysql_replication_hostgroups VALUES (10,20,'read_only','')" 2>&1 | grep -v "Using a password"
${EXEC_PROXY} "LOAD MYSQL SERVERS TO RUNTIME" 2>&1 | grep -v "Using a password"
${EXEC_PROXY} "SAVE MYSQL SERVERS TO DISK" 2>&1 | grep -v "Using a password"

${EXEC_PROXY} "INSERT INTO mysql_users(username,password,default_hostgroup,transaction_persistent)
               VALUES ('appuser','apppass',10,0)" 2>&1 | grep -v "Using a password"
${EXEC_PROXY} "LOAD MYSQL USERS TO RUNTIME" 2>&1 | grep -v "Using a password"
${EXEC_PROXY} "SAVE MYSQL USERS TO DISK" 2>&1 | grep -v "Using a password"

${EXEC_PROXY} "INSERT INTO mysql_query_rules(rule_id,active,match_pattern,destination_hostgroup)
               VALUES (1,1,'^SELECT.*FOR UPDATE$',10)" 2>&1 | grep -v "Using a password"
${EXEC_PROXY} "INSERT INTO mysql_query_rules(rule_id,active,match_pattern,destination_hostgroup)
               VALUES (2,1,'^SELECT',20)" 2>&1 | grep -v "Using a password"
${EXEC_PROXY} "LOAD MYSQL QUERY RULES TO RUNTIME" 2>&1 | grep -v "Using a password"
${EXEC_PROXY} "SAVE MYSQL QUERY RULES TO DISK" 2>&1 | grep -v "Using a password"


