#!/bin/bash

##### make directory for each container######

mkdir -p /etc/bsweb
  for i in {1..4}; do
    mkdir -p /vol/var/www/html${i}
    echo "hi fucker ${i}" > /vol/var/www/html${i}/index.html
  done

##### make the docker-compose yaml ##########

cat << EOF-compose > /etc/bsweb/docker-compose.yml
services:
  bsweb1:
    container_name: bsweb1
      
    hostname: bsweb1
    image: bstewart1992/bsweb:0.6
    ports:
      - target: 80
        published: 8081
        protocol: tcp
    restart: always
    volumes:
      - "/vol/var/www/html1:/var/www/html:Z"

  bsweb2:
    container_name: bsweb2
      
    hostname: bsweb2
    image: bstewart1992/bsweb:0.6
    ports:
      - target: 80
        published: 8082
        protocol: tcp
    restart: always
    volumes:
      - "/vol/var/www/html2:/var/www/html:Z"
  
  bsweb3:
    container_name: bsweb3
      
    hostname: bsweb3
    image: bstewart1992/bsweb:0.6
    ports:
      - target: 80
        published: 8083
        protocol: tcp
    restart: always
    volumes:
      - "/vol/var/www/html3:/var/www/html:Z"
  
  bsweb4:
    container_name: bsweb4
      
    hostname: bsweb4
    image: bstewart1992/bsweb:0.6
    ports:
      - target: 80
        published: 8084
        protocol: tcp
    restart: always
    volumes:
      - "/vol/var/www/html4:/var/www/html:Z"
  

EOF-compose