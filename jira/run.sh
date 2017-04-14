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
  --name dagen-jira \
  --net dagen \
  -d --restart=always \
  -v jira-data:/var/atlassian/jira \
  -e "X_PROXY_NAME=jira.dagenatifi.no" \
  -e "X_PROXY_PORT=443" \
  -e "X_PROXY_SCHEME=https" \
  -e "X_CROWD_PASSWORD=$CROWDPASS" \
  dagenatifi/jira

docker inspect -f 'created:{{.Created}}   {{.Image}}' dagen-jira >>run.log
