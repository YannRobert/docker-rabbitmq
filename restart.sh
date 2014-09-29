#!/bin/bash

docker kill rabbitmq
docker rm rabbitmq

set -e

mkdir -p ~/rabbitmq-etc
mkdir -p ~/rabbitmq-ssl

# On a public server, the management plugin should be exposed on port 80 and 443 in order to be accessible to user behind a firewall
# docker run -d -p 5672:5672 -p 5671:5671 -p 443:15672 -v ~/rabbitmq-etc:/etc/rabbitmq -v /etc/localtime:/etc/localtime:ro -e RABBITMQ_PASS="adminpassword" --name rabbitmq rabbitmq
# but on a developer machine, the default port are more suitable
docker run -d -p 5672:5672 -p 5671:5671 -p 15672:15672 -v ~/rabbitmq-etc:/etc/rabbitmq -v /etc/localtime:/etc/localtime:ro -e RABBITMQ_PASS="adminpassword" --name rabbitmq rabbitmq

echo "Waiting for the server to start ..."
sleep 5

docker logs rabbitmq


echo "Attempting to connect with curl ..."

#curl http://localhost:15672
curl http://localhost:5672

curl -k https://localhost:5671
curl -k https://localhost:15672

