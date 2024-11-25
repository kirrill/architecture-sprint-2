#!/bin/bash

###
# Получаем общее кол-во документов в базе
###
echo "Общее кол-во документов в базе:"
docker compose exec -T mongos_router mongosh --port 27017 --quiet <<EOF
use somedb
db.helloDoc.countDocuments()
exit();
EOF

###
# Получаем кол-во записей на Шарде-1 БД-1
###
echo "Кол-во документов на Шарде-1 БД-1:"
docker compose exec -T shard1_db1 mongosh --port 27018 --quiet <<EOF
use somedb
db.helloDoc.countDocuments()
exit();
EOF

###
# Получаем кол-во записей на Шарде-1 БД-2
###
echo "Кол-во документов на Шарде-1 БД-2:"
docker compose exec -T shard1_db2 mongosh --port 27019 --quiet <<EOF
use somedb
db.helloDoc.countDocuments()
exit();
EOF


###
# Получаем кол-во записей на Шарде-1 БД-3
###
echo "Кол-во документов на Шарде-1 БД-3:"
docker compose exec -T shard1_db3 mongosh --port 27020 --quiet <<EOF
use somedb
db.helloDoc.countDocuments()
exit();
EOF


###
# Получаем кол-во записей на Шарде-2 БД-1
###
echo "Кол-во документов на Шарде-2 БД-1:"
docker compose exec -T shard2_db1 mongosh --port 27021 --quiet <<EOF
use somedb
db.helloDoc.countDocuments()
exit();
EOF

###
# Получаем кол-во записей на Шарде-2 БД-2
###
echo "Кол-во документов на Шарде-2 БД-2:"
docker compose exec -T shard2_db2 mongosh --port 27022 --quiet <<EOF
use somedb
db.helloDoc.countDocuments()
exit();
EOF

###
# Получаем кол-во записей на Шарде-2 БД-3
###
echo "Кол-во документов на Шарде-2 БД-3:"
docker compose exec -T shard2_db3 mongosh --port 27023 --quiet <<EOF
use somedb
db.helloDoc.countDocuments()
exit();
EOF