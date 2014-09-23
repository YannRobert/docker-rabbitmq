#!/bin/bash

set -e

if [ ! -f /.rabbitmq_password_set ]; then
	/set_rabbitmq_password.sh
fi

if [ -f /etc/rabbitmq/rabbitmq.config ]; then
    echo "File /etc/rabbitmq/rabbitmq.config already exists, content is :"
    echo "<<"
    cat /etc/rabbitmq/rabbitmq.config
    echo ">>"
fi

mkdir -p /etc/rabbitmq

cp /rabbitmq-config/rabbitmq.config /etc/rabbitmq
cp /rabbitmq-config/enabled_plugins /etc/rabbitmq

/ssl.sh

rabbitmq-plugins enable rabbitmq_management

/usr/sbin/rabbitmq-server
