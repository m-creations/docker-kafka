#!/bin/bash

# set -x # uncomment for debugging
cd ${KAFKA_HOME}

# Start every container with Zookeeper and Kafka running detached. 
# If no configs are set with `docker run -e ....`, use the defaults.

# Zookeeper, if at all

if [ "${ZOO}" != "true" ] #if $ZOO is anything but true (the default), then it's false.
then
  echo "Zookeeper set to not start. Please make sure you have configured Kafka to connect to another Zookeeper."
else
  if [ "${ZOOKEEPER_CONFIG_FILE}" == "" ]
  then 
    echo "No Zookeeper-configuration file was given, starting Zookeeper server with the default config/zookeeper.properties"
    ZOOKEEPER_CONFIG_FILE=config/zookeeper.properties
  else
    echo "Starting Zookeeper server with the configuration file ${ZOOKEEPER_CONFIG_FILE}"
  fi
  ((bin/zookeeper-server-start.sh "${ZOOKEEPER_CONFIG_FILE}")&)&
fi

# Kafka

if [ "${KAFKA_CONFIG_FILE}" == "" ]
then 
  echo "No configuration file given, starting Kafka server with the default config/server.properties"
  KAFKA_CONFIG_FILE=config/server.properties
else
  echo "Starting Kafka server with the configuration file ${KAFKA_CONFIG_FILE}"
fi

# The exec below will make kafka PID 1 of this container. 

exec bin/kafka-server-start.sh "${KAFKA_CONFIG_FILE}"


