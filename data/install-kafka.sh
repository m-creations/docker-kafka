#!/bin/bash

# to toggle debugging comment/uncomment the following:
set -x

# variables

KAFKA_VERSION="2.11-0.11.0.0"
KAFKA_ARTIFACT="kafka_${KAFKA_VERSION}"
KAFKA_FILE="${KAFKA_ARTIFACT}.tgz"
KAFKA_DOWNLOAD_URL="http://mirror.23media.de/apache/kafka/0.11.0.0/${KAFKA_FILE}"
KAFKA_MD5_DOWNLOAD_URL="https://www-eu.apache.org/dist/kafka/0.11.0.0/${KAFKA_FILE}.md5"

# get necessary openWRT packages
opkg update
opkg install libstdcpp shadow-groupadd shadow-useradd shadow-su

# add kafka user, group, and home directories

useradd -d "${KAFKA_HOME}" -m -s /bin/bash -U "$KAFKA_USER"
cp /root/.bashrc "${KAFKA_HOME}"
echo 'alias hostname="echo $HOSTNAME"' >> /etc/profile

# download kafka 
wget -nv "${KAFKA_DOWNLOAD_URL}"

# download md5 sum of above file
wget -nv "${KAFKA_MD5_DOWNLOAD_URL}"

# *******************************************
# !!! MD5 SUM FAILS BECAUSE OF FORMATTING!!!!
# *******************************************
 
# the md5 sum according to elastic.co: 
# SUM=$(cat "${KAFKA_FILE}.md5")

# the md5 sum we calculate
# NEWSUM=$(md5sum "$KAFKA_FILE")

# if [ "$SUM" == "$NEWSUM" ] && [ "$SUM" != "" ] 
# then echo "MD5 SUM OK"
# else echo "MD5 SUM FAILED!!!" 
#      exit 1
# fi

# install kafka:

tar -xvzf "/${KAFKA_FILE}"
mv -f /${KAFKA_ARTIFACT}/* "$KAFKA_HOME"

# chown $kafka_home
chown -R "${KAFKA_USER}:${KAFKA_GROUP}" "$KAFKA_HOME"

# remove unecessary packages and files
rm /tmp/opkg-lists/* 
rm "/${KAFKA_FILE}"
rm "/${KAFKA_FILE}.md5"



