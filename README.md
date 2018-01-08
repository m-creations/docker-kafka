# Kafka docker image on top of OpenWRT

Kafka Version 1.0.0 for Scala 2.11

Following https://kafka.apache.org/quickstart

Kafka includes Zookeeper, which is not separately installed here. 

## Requirements

[Docker](https://www.docker.com/)


## Installation 


Download or clone the repository and from inside the repository's directory execute: 

```
docker build . -t docker-openwrt-kafka:2.11-1.0.0
```

## Usage

To run a Kafka server listening on port 9092 execute:

```
docker run -p 9092:9092 docker-openwrt-kafka:2.11-1.0.0
```

## Warning

GPG Signature **not checked**. 

# Test

A test is under preparation. 
