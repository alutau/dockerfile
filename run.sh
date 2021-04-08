
#!/usr/bin/env bash

# run.sh

# run the container in the background
# /data is persisted using a named container

docker run \
    --detach \
    --rm \
    -p8086:80 \
    -p8080:443 \
    -v name:/data \
    --name="apache2" \
    apache2
