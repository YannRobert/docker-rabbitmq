#!/bin/bash

set -e

if [ ! -f /.rabbitmq_password_set ]; then
	/set_rabbitmq_password.sh
fi

cat /etc/rabbitmq/rabbitmq.config

mkdir -p /etc/rabbitmq

cp /rabbitmq-config/rabbitmq.config /etc/rabbitmq
cp /rabbitmq-config/enabled_plugins /etc/rabbitmq

/ssl.sh

rabbitmq-plugins enable rabbitmq_management

/usr/sbin/rabbitmq-server
