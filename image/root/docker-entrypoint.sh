#!/bin/bash

# set -x # uncomment for debugging
cd ${KAFKA_HOME}
su - kafka

# Start every container with Zookeeper and Kafka running detached. 

echo "Starting Zookeeper server"
((bin/zookeeper-server-start.sh config/zookeeper.properties)&)&
echo "Starting kafka server"
((bin/kafka-server-start.sh config/server.properties)&)&



