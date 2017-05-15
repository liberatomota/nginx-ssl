#!/bin/bash

DIRECTORY=$(dirname $BASH_SOURCE)
ROOTCA=$DIRECTORY/rootCA
LOCALHOST=$DIRECTORY/itcenter_onsip

source $DIRECTORY/../.env \
  && export DOCKER_SERVER \
  && openssl genrsa -out $LOCALHOST.key 2048 \
  && openssl req -new -key $LOCALHOST.key -out $LOCALHOST.csr -config $DIRECTORY/openssl.cnf \
  && openssl x509 -req -in $LOCALHOST.csr -out $LOCALHOST.crt -CA $ROOTCA.crt -CAkey $ROOTCA.key -CAcreateserial -days 365 -sha256 -extensions v3_req -extfile $DIRECTORY/openssl.cnf \
  && rm .srl \
  && cat $LOCALHOST.crt $LOCALHOST.key > $LOCALHOST.pem
