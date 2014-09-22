#!/bin/bash

set -e

if [ -f /.rabbitmq_password_set ]; then
	echo "RabbitMQ password already set!"
	exit 0
fi

PASS=${RABBITMQ_PASS:-$(pwgen -s 12 1)}
USER=${RABBITMQ_USER:-"admin"}
_word=$( [ ${RABBITMQ_PASS} ] && echo "preset" || echo "random" )
echo "=> Securing RabbitMQ with a ${_word} password"

# replacing well-known values set in the template file by the actual values
sed -i.bak s/adminlogin/$USER/g /rabbitmq-config/rabbitmq.config
sed -i.bak s/adminpassword/$PASS/g /rabbitmq-config/rabbitmq.config

echo "=> Done!"
touch /.rabbitmq_password_set

echo "========================================================================"
echo "You can now connect to this RabbitMQ server using, for example:"
echo ""
echo "    curl --user $USER:$PASS http://<host>:<port>/api/vhosts"
echo ""
echo "Please remember to change the above password as soon as possible!"
echo "========================================================================"
