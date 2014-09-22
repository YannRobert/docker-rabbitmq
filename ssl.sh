#!/bin/bash

# set up ssl certificates

if [[ ! -f /etc/rabbitmq/ssl/.ssl_config_generated ]]; then
    cd /ssl/testca
    openssl req -x509 -config openssl.cnf -newkey rsa:2048 -days 365 -out cacert.pem -outform PEM -subj /CN=MyTestCA/ -nodes
    cd ..
    mkdir server
    cd server
    openssl genrsa -out key.pem 2048
    openssl req -new -key key.pem -out req.pem -outform PEM -subj /CN=$(hostname)/O=server/ -nodes
    cd ../testca
    openssl ca -config openssl.cnf -in ../server/req.pem -out ../server/cert.pem -notext -batch -extensions server_ca_extensions

    mkdir -p /etc/rabbitmq/ssl/
    cp /ssl/testca/cacert.pem /etc/rabbitmq/ssl/
    cp /ssl/server/cert.pem /etc/rabbitmq/ssl/
    cp /ssl/server/key.pem /etc/rabbitmq/ssl/

    touch /etc/rabbitmq/ssl/.ssl_config_generated
else
    echo "SSL directory already exists, not generating SSL certificat"
fi
