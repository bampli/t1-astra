#!/bin/bash

# Cleaning up docker environment
docker rm -f $(docker ps -qa)
docker network prune -f
docker volume prune -f
docker system prune -a -f
