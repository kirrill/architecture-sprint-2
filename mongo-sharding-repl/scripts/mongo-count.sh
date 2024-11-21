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
# Получаем кол-во записей на Шарде-1
###
echo "Кол-во документов на Шарде-1:"
docker compose exec -T shard1 mongosh --port 27018 --quiet <<EOF
use somedb
db.helloDoc.countDocuments()
exit();
EOF

###
# Получаем кол-во записей на Шарде-2
###
echo "Кол-во документов на Шарде-2:"
docker compose exec -T shard2 mongosh --port 27019 --quiet <<EOF
use somedb
db.helloDoc.countDocuments()
exit();
EOF