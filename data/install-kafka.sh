#!/bin/bash

# to toggle debugging comment/uncomment the following:
set -x

# instalation specific variables

KAFKA_ARTIFACT="kafka_${SCALA_VERSION}-${KAFKA_VERSION}"
KAFKA_FILE="${KAFKA_ARTIFACT}.tgz"
KAFKA_DOWNLOAD_URL="http://mirror.23media.de/apache/kafka/${KAFKA_VERSION}/${KAFKA_FILE}"
KAFKA_MD5_FILE="https://www.apache.org/dist/kafka/${KAFKA_VERSION}/${KAFKA_FILE}.md5"

# get necessary openWRT packages
opkg update
opkg install libstdcpp shadow-groupadd shadow-useradd shadow-su

# add kafka user, group, and home directories

useradd -d "${KAFKA_HOME}" -m -s /bin/bash -U "$KAFKA_USER"
cp /root/.bashrc "${KAFKA_HOME}"
echo 'alias hostname="echo $HOSTNAME"' >> /etc/profile

# download kafka
wget -nv "${KAFKA_DOWNLOAD_URL}"

# download and get kafka's md5 signature

wget -nv "${KAFKA_MD5_FILE}"

# check md5 sum  of $KAFKA_FILE. 

# *******************************************
# !!! MD5 SUM FAILS BECAUSE OF FORMATTING!!!!
# *******************************************

# the md5 sum according to Apache: 
SUM=`cat "${KAFKA_FILE}.md5" | tr -d '\n' | awk '{ line = sprintf("%s", $0); gsub(/[[:space:]]/, "", line); split(line, parts, ":"); print tolower(parts[2]) }'`

# the md5 sum we calculate
NEWSUM=`md5sum "${KAFKA_FILE}" | awk '{print $1}'`

if [ "$SUM" == "$NEWSUM" ] && [ "$SUM" != "" ] 
then echo "MD5 SUM OK"
else echo "MD5 SUM FAILED!!!" 
     exit 1
fi


# install kafka:

tar -xvzf "/${KAFKA_FILE}"
mv -f /${KAFKA_ARTIFACT}/* "$KAFKA_HOME"

# chown $kafka_home
chown -R "${KAFKA_USER}:${KAFKA_GROUP}" "$KAFKA_HOME"
chown -R "${KAFKA_USER}:${KAFKA_GROUP}" /data

# remove unecessary packages and files
rm /tmp/opkg-lists/*
rm "/${KAFKA_FILE}"
