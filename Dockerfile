FROM ubuntu:trusty
MAINTAINER Yann Robert <yann.robert@anantaplex.com>

# Install RabbitMQ
RUN apt-get update && \
    apt-get install -y rabbitmq-server pwgen && \
    rabbitmq-plugins enable rabbitmq_management && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add scripts
ADD run.sh /run.sh
ADD set_rabbitmq_password.sh /set_rabbitmq_password.sh
RUN chmod 755 ./*.sh

EXPOSE 5672 15672
CMD ["/run.sh"]
