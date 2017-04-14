#!/bin/bash

docker run \
  --name dagen-crowd \
  --net dagen \
  -d --restart=always \
  -v crowd-data:/var/atlassian/crowd \
  dagen/crowd

docker inspect -f 'created:{{.Created}}   {{.Image}}' dagen-crowd >>run.log
