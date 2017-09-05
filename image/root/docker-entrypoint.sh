#!/bin/bash

set -x
cd /opt/kafka
su - kafka


# Add kafka as command if needed

# if no arguments are given to the container, or if the only argument is "kafka"
if   [[ -z "$1" || ( "$1" = 'kafka' && -z "$2" ) ]] 
# then start kafka with the default config file I made
then 
echo "Starting zookeeper server"
# run it detached without using disown or nohup
((bin/zookeeper-server-start.sh config/zookeeper.properties)&)&
echo "Starting kafka server"
bin/kafka-server-start.sh config/server.properties
# else just execute the argument that was given at the start of the container.
else exec $*
fi
