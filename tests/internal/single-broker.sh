#!/bin/sh

# -------------------------------------------------------------------
# This script is intended to be run from inside a docker container 
# which has Kafka installed, to test if the installation works as 
# described in:
# 
# https://kafka.apache.org/documentation.html#quickstart
# -------------------------------------------------------------------

 set -x # uncomment for debugging

# create a topic named test with a single partition and one replica, using the local zookeeper.

echo "================================"

cd ${KAFKA_HOME}
pwd

bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic test


# see the test topic

TEST_STRING="$(bin/kafka-topics.sh --list --zookeeper localhost:2181)"

if [ "${TEST_STRING}" != "test" ]
then 
  echo "CREATE TEST TOPIC FAILED"
  exit 1
fi

# send a message

bin/kafka-console-producer.sh --broker-list localhost:9092 --topic test <<EOF
this is a test
EOF

# consume that message

TEST_STRING="$(bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic test --from-beginning --max-messages 1)"

if [ "${TEST_STRING}" != "this is a test" ]
then 
  echo "CONSUME MESSAGE FAILED"
  exit 1
fi



