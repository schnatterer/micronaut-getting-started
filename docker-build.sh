#!/bin/sh
docker build . -t micronaut-getting-started
echo
echo
echo "To run the docker container execute:"
echo "    $ docker run --network host micronaut-getting-started"
