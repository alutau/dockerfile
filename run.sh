#!/usr/bin/env bash

# debug.sh

# run container without making it a daemon - useful to see logging output

docker run \
    --detach \
    --rm \
    -p8086:80 \
    -v name:/data \
    --name="access" \
    access
