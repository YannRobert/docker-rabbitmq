#!/bin/bash

docker kill rabbitmq
docker rm rabbitmq

set -e

mkdir -p ~/rabbitmq-etc
mkdir -p ~/rabbitmq-ssl

docker run -d -p 5672:5672 -p 5671:5671 -p 15672:15672 -p 15671:15671 -v ~/rabbitmq-etc:/etc/rabbitmq -v /etc/localtime:/etc/localtime:ro -e RABBITMQ_PASS="adminpassword" --name rabbitmq rabbitmq

echo "Waiting for the server to start ..."
sleep 5

docker logs rabbitmq


echo "Attempting to connect with curl ..."

#curl http://localhost:15672
curl http://localhost:5672

curl -k https://localhost:5671
curl -k https://localhost:15672

