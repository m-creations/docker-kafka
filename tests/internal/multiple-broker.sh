#!/bin/sh

# -------------------------------------------------------------------
# This script is intended to be run from inside a docker container 
# which has Kafka installed and running (standard cmd), to test if the installation works as 
# described in:
# 
# https://kafka.apache.org/documentation.html#quickstart
# -------------------------------------------------------------------

# set -x # uncomment for debugging

# Expand the cluster to 3 nodes, by adding 2 more brokers.

cd ${KAFKA_HOME}

sed 's/broker.id=0/broker.id=1/1; s/#listeners/listeners/1; s/:9092/:9093/1; s/kafka-logs/kafka-logs-1/1' config/server.properties > config/server-1.properties
sed 's/broker.id=0/broker.id=2/1; s/#listeners/listeners/1;  s/:9092/:9094/1; s/kafka-logs/kafka-logs-2/1' config/server.properties > config/server-2.properties

((bin/kafka-server-start.sh config/server-1.properties)&)&
((bin/kafka-server-start.sh config/server-2.properties)&)&

# wait until the servers are up

sleep 5

# create new topic with replication factor 3

bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 3 --partitions 1 --topic my-replicated-topic

TEST_STRING="$(bin/kafka-topics.sh --describe --zookeeper localhost:2181 --topic my-replicated-topic | sed -n 1p)"
TEST_RESULT=$'Topic:my-replicated-topic\tPartitionCount:1\tReplicationFactor:3\tConfigs:'

if [ "$TEST_STRING" = "$TEST_RESULT" ] 
then echo "ok"
else echo "not ok"
     exit 1
fi


