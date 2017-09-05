# Kafka docker image on top of OpenWRT

Following https://kafka.apache.org/quickstart

Kafka includes Zookeeper, which is not separately installed here. 

## Requirements

[Docker](https://www.docker.com/)

## Installation 


Download or clone the repository and from inside the repository's directory execute: 

```
docker build . -t docker-openwrt-kafka:2.11-0.11.0.0
```

## Usage

To run a Kafka server listening on port 9092 execute:

```
docker run -p 9092:9092 docker-openwrt-kafka:2.11-0.11.0.0
```

# Test

A test is under preparation. 
