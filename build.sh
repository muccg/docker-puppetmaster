#!/bin/sh
#
# Script to build images
#

# break on error
set -e

REPO='muccg'
DATE=`date +%Y.%m.%d`

: ${DOCKER_BUILD_OPTIONS:="--pull=true"}

image="${REPO}/puppetmaster:latest"
echo "################################################################### ${image}"

# blindly pull what we are trying to build, warm up cache
docker pull ${image} || true

# build
docker build ${DOCKER_BUILD_OPTIONS} -t ${image} .
docker tag ${image} ${image}-${DATE}

docker inspect ${image}

# push
docker push ${image}
docker push ${image}-${DATE}
