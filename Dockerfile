FROM ubuntu:trusty
MAINTAINER Yann Robert <yann.robert@anantaplex.com>

ADD rabbitmq-signing-key-public.asc /tmp/rabbitmq-signing-key-public.asc
RUN echo "deb http://www.rabbitmq.com/debian/ testing main" >> /etc/apt/sources.list && \
    apt-key add /tmp/rabbitmq-signing-key-public.asc

# Install RabbitMQ
RUN apt-get update && \
    apt-get install -y rabbitmq-server pwgen openssl && \
    rabbitmq-plugins enable rabbitmq_management && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ADD ssl /ssl
ADD ssl.sh /ssl.sh
ADD rabbitmq-config /rabbitmq-config

RUN mkdir -p /etc/rabbitmq

# Add scripts
ADD run.sh /run.sh
ADD set_rabbitmq_password.sh /set_rabbitmq_password.sh
RUN chmod 755 ./*.sh

# RUN mkdir -p /var/lib/rabbitmq/mnesia && mkdir -p /var/log/rabbitmq

# VOLUME ["/var/lib/rabbitmq/mnesia", "/var/log/rabbitmq"]

EXPOSE 5672 15672
CMD ["/run.sh"]
