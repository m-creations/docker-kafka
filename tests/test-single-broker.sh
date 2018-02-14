#!/bin/sh

# set -x # uncomment for debugging

LOCAL_DIR="$(pwd)"

docker run -d --name single -v "${LOCAL_DIR}/tests/internal/single-broker.sh":/opt/kafka/single-broker.sh openwrt-kafka:1.0.0

sleep 5

docker exec single sh /opt/kafka/single-broker.sh
