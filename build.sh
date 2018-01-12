#!/bin/bash

# Universal build script for docker containers
# Git project name has to start with 'docker-'

# get name of app from the path
# /../../docker-app_name > app_name
APP_NAME=${PWD##*-}
DOCKER_PROJ_NAME=${DOCKER_PROJ_NAME:-''}

# set version based on the git commit
VERSION=$(git describe --abbrev=7 --tags)
BRANCH=$(git rev-parse --abbrev-ref HEAD)

TAG_BRANCH=""
if [ ${BRANCH} != "master" ]; then
    TAG_BRANCH=${BRANCH}-
fi

FULL_VERSION=${TAG_BRANCH}${VERSION}

docker build --build-arg http_proxy=${http_proxy:-} \
       --build-arg https_proxy=${https_proxy:-} \
       --build-arg no_proxy=${no_proxy:-} \
       $@ -t ${DOCKER_PROJ_NAME}${APP_NAME}:${FULL_VERSION} .

docker tag ${DOCKER_PROJ_NAME}${APP_NAME}:${FULL_VERSION} ${DOCKER_PROJ_NAME}${APP_NAME}:latest
