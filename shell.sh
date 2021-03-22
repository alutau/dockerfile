#!/usr/bin/env bash

# debug.sh

# run container without making it a daemon - useful to see logging output

docker run \
    --rm \
    -it \
    -p8086:80 \
    --name="protegido" \
    -v `pwd`:/home/app \
    protegido
