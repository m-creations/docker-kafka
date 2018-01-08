#!/bin/bash

# to toggle debugging comment/uncomment the following:
set -x

# variables

SCALA_VERSION="2.11"
KAFKA_VERSION="1.0.0"
KAFKA_ARTIFACT="kafka_${SCALA_VERSION}-${KAFKA_VERSION}"
KAFKA_FILE="${KAFKA_ARTIFACT}.tgz"
KAFKA_DOWNLOAD_URL="http://mirror.23media.de/apache/kafka/${KAFKA_VERSION}/${KAFKA_FILE}"
KAFKA_ASC_FILE="https://www.apache.org/dist/kafka/${KAFKA_VERSION}/${KAFKA_FILE}.asc"

# get necessary openWRT packages
opkg update
opkg install libstdcpp shadow-groupadd shadow-useradd shadow-su

# add kafka user, group, and home directories

useradd -d "${KAFKA_HOME}" -m -s /bin/bash -U "$KAFKA_USER"
cp /root/.bashrc "${KAFKA_HOME}"
echo 'alias hostname="echo $HOSTNAME"' >> /etc/profile

# download kafka
wget -nv "${KAFKA_DOWNLOAD_URL}"

# download and get kafka's gpg signature

wget -nv "${KAFKA_ASC_FILE}"

# TODO: Install gpg and check signature of $KAFKA_FILE. 

# install kafka:

tar -xvzf "/${KAFKA_FILE}"
mv -f /${KAFKA_ARTIFACT}/* "$KAFKA_HOME"

# chown $kafka_home
chown -R "${KAFKA_USER}:${KAFKA_GROUP}" "$KAFKA_HOME"
chown -R "${KAFKA_USER}:${KAFKA_GROUP}" /data

# remove unecessary packages and files
rm /tmp/opkg-lists/*
rm "/${KAFKA_FILE}"
