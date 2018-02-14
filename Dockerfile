FROM mcreations/openwrt-java:8

LABEL maintainer="Ioanna M. Dimitriou <dimitriou@m-creations.com>"
LABEL version="2.11-1.0.0"
LABEL vendor="mcreations"
LABEL name="docker-openwrt-kafka"

ENV SCALA_VERSION="2.11"
ENV KAFKA_VERSION="1.0.0"

EXPOSE 9092

# non root user 

ENV KAFKA_HOME="/opt/kafka"
ENV KAFKA_USER="kafka"
ENV KAFKA_GROUP="$KAFKA_USER"

# If no values are set during docker run, then the defaults will be used (see /docker-entrypoint.sh)

ENV KAFKA_CONFIG_FILE=""
ENV ZOOKEEPER_CONFIG_FILE=""
ENV ZOO="true"

# installation scripts are here:

RUN mkdir -p /data 

ADD image/root /
ADD data/ /data

# install kafka

RUN bash /data/install-kafka.sh

CMD [ "/start-kafka-default.sh" ]
