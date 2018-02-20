#!/bin/sh

# set -x # uncomment for debugging

LOCAL_DIR="$(pwd)"

docker run -d --name multiple -v "${LOCAL_DIR}/tests/internal/multiple-broker.sh":/opt/kafka/multiple-broker.sh openwrt-kafka:1.0.0

sleep 5

docker exec -it multiple sh /opt/kafka/multiple-broker.sh

