#!/bin/bash

docker run \
    -d \
    --net dagen \
    --restart always \
    --name dagen-nginx \
    -e LE_CONTACT_EMAIL=webansvarlig@dagenatifi.no \
    -v letsencrypt-certs:/opt/letsencrypt.sh/certs \
    -v letsencrypt-accounts:/opt/letsencrypt.sh/accounts \
    -v "$(pwd)/nginx/nginx.conf":/etc/nginx/nginx.conf \
    -v "$(pwd)/nginx/okoreports.htpasswd":/etc/nginx/okoreports.htpasswd \
    -v "$(pwd)/nginx/conf.d":/etc/nginx/conf.d \
    -p 80:80 -p 443:443 \
    henrist/nginx-letsencrypt
