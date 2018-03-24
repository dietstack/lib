#!/bin/bash

set -e
# Universal push script for DietStack docker containers
# We need to set two variables in order to be able to login
# to public docker hub: $DOCKER_LOGIN and $DOCKER_PASS
. lib/functions.sh                                                                                  
                                                                                                    
FULL_VERSION=$(get_full_version)

test -z $DOCKER_LOGIN && { echo "DOCKER_LOGIN not set" && exit 1; }
test -z $DOCKER_PASS && { echo "DOCKER_PASS not set" && exit 1; }

# Git project name has to start with 'docker-'

# get name of app from the path
# /../../docker-app_name > app_name
APP_NAME=${PWD##*-}
DOCKER_PROJ_NAME=${DOCKER_PROJ_NAME:-''}

FULL_VERSION=$(get_full_version)

docker login -u $DOCKER_LOGIN -p $DOCKER_PASS
docker push ${DOCKER_PROJ_NAME}${APP_NAME}:${FULL_VERSION}
docker push ${DOCKER_PROJ_NAME}${APP_NAME}:latest
