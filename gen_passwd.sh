#!/bin/sh

USER_NAME=${USERNAME}
PASSWD=${PASSWORD}

echo "Generating password for user ${USER_NAME}"

CRYPTPASS=`openssl passwd -crypt ${PASSWD}`

echo "${USER_NAME}:${CRYPTPASS}" >> /etc/nginx/.htpasswd