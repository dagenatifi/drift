#!/bin/bash

if [ ! -f crowd-pass.txt ]; then
    printf "Enter password for Crowd service: "
    read -s CROWDPASS
    echo
    echo "Saving to crowd-pass.txt for later use"
    echo "$CROWDPASS" >crowd-pass.txt
fi

CROWDPASS=$(<crowd-pass.txt)

docker run \
  --name dagen-confluence \
  --net dagen \
  -d --restart=always \
  -v confluence-data:/var/atlassian/confluence \
  -e "X_PROXY_NAME=wiki.dagenatifi.no" \
  -e "X_PROXY_PORT=443" \
  -e "X_PROXY_SCHEME=https" \
  -e "X_CROWD_PASSWORD=$CROWDPASS" \
  dagen/confluence

docker inspect -f 'created:{{.Created}}   {{.Image}}' dagen-confluence >>run.log
