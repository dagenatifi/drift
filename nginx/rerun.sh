#!/bin/bash

docker stop dagen-nginx
docker rm -f dagen-nginx
./run.sh
