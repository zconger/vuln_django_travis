#!/usr/bin/env bash

docker pull stackhawk/hawkscan

docker-compose up --detach

docker run -it --rm -v $(pwd):/hawk \
  -e APP_ID=830780ac-07be-4995-89d4-0645f1f0e95a \
  -e HOST=http://localhost:8020 \
  -e API_KEY=${HAWK_API_KEY} \
  -e ENV=Development \
  stackhawk/hawkscan