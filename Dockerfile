FROM mcreations/openwrt-java:8

LABEL maintainer="Ioanna M. Dimitriou <dimitriou@m-creations.com>"
LABEL version="2.11-1.0.0"
LABEL vendor="mcreations"
LABEL name="docker-openwrt-kafka"

EXPOSE 9092

ENV KAFKA_HOME /opt/kafka

# add user: 

ENV KAFKA_USER="kafka"
ENV KAFKA_GROUP="$KAFKA_USER"

# installation scripts are here:

RUN mkdir -p /data 

ADD image/root /
ADD data/ /data

# install kafka

RUN bash /data/install-kafka.sh

# start container with this script 

ENTRYPOINT ["/docker-entrypoint.sh"]

# with no arguments
 
CMD [ "" ]
