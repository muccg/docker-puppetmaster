#!/bin/sh
#
# Script to build images
#

# break on error
set -e
set -x
set -a
: ${DOCKER_USE_HUB:="0"}

DATE=`date +%Y.%m.%d`
DOCKER_PUPPET_VERSION=3.8.7
DOCKER_LIBRARIAN_PUPPET_VERSION=2.2.3


ci_docker_login() {
    if [ -z ${DOCKER_EMAIL+x} ]; then
        DOCKER_EMAIL=${bamboo_DOCKER_EMAIL}
    fi
    if [ -z ${DOCKER_USERNAME+x} ]; then
        DOCKER_USERNAME=${bamboo_DOCKER_USERNAME}
    fi
    if [ -z ${DOCKER_PASSWORD+x} ]; then
        DOCKER_PASSWORD=${bamboo_DOCKER_PASSWORD}
    fi

    docker login -e "${DOCKER_EMAIL}" -u ${DOCKER_USERNAME} --password="${DOCKER_PASSWORD}"
}


# warm up cache
docker pull muccg/puppetmaster:latest || true

docker-compose build puppetmaster
docker inspect muccg/puppetmaster:latest

docker tag muccg/puppetmaster:latest muccg/puppetmaster:${DOCKER_PUPPET_VERSION}
docker tag muccg/puppetmaster:latest muccg/puppetmaster:${DOCKER_PUPPET_VERSION}-${DATE}

if [ ${DOCKER_USE_HUB} = "1" ]; then
    ci_docker_login
    docker push muccg/puppetmaster:${DOCKER_PUPPET_VERSION}
    docker push muccg/puppetmaster:${DOCKER_PUPPET_VERSION}-${DATE}
fi
