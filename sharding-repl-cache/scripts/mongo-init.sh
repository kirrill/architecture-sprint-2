#!/bin/bash

###
# Инициализируем сервер конфигурации
###

docker compose exec -T configSrv mongosh --port 27016 --quiet <<EOF
rs.initiate({ _id : "config_server", configsvr: true, members: [{ _id : 0, host : "configSrv:27016" }]});
exit(); 
EOF

###
# Инициализируем Шард-1
###

docker compose exec -T shard1_db1 mongosh --port 27018 --quiet <<EOF
rs.initiate({ _id : "shard1", members: [{ _id : 0, host : "shard1_db1:27018" },{ _id : 1, host : "shard1_db2:27019" },{ _id : 2, host : "shard1_db3:27020" }]});
exit(); 
EOF

###
# Инициализируем Шард-2
###

docker compose exec -T shard2_db1 mongosh --port 27021 --quiet <<EOF
rs.initiate({ _id : "shard2", members: [{ _id : 0, host : "shard2_db1:27021" },{ _id : 1, host : "shard2_db2:27022" },{ _id : 2, host : "shard2_db3:27023" }]});
exit(); 
EOF

###
# Инициализируем роутер и наполнение БД
###

docker compose exec -T mongos_router mongosh --port 27017 --quiet <<EOF
sh.addShard( "shard1/shard1_db1:27018");
sh.addShard( "shard1/shard1_db2:27019");
sh.addShard( "shard1/shard1_db3:27020");
sh.addShard( "shard2/shard2_db1:27021");
sh.addShard( "shard2/shard2_db2:27022");
sh.addShard( "shard2/shard2_db3:27023");
sh.enableSharding("somedb");
sh.shardCollection("somedb.helloDoc", { "name" : "hashed" } )
use somedb
for(var i = 0; i < 1000; i++) db.helloDoc.insertOne({age:i, name:"ly"+i})
exit();
EOF

