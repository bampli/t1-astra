#!/bin/sh

docker rmi $(docker images --filter=reference='localhost:5000/nginx-image' -q)
docker rmi $(docker images --filter=reference='localhost:5000/t1-image' -q)