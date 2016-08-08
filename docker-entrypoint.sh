#!/bin/bash

function defaults {
    : ${PUPPET_DNS_ALT_NAMES="localhost,puppetmaster,master"}

    echo "PUPPET_DNS_ALT_NAMES is ${PUPPET_DNS_ALT_NAMES}"

    export PUPPET_DNS_ALT_NAMES
}

defaults

if [ "$1" = 'puppetmaster' ]; then
    echo "[RUN]: Launching puppet master"
    exec /usr/local/bin/puppet master --confdir "/data" --dns_alt_names "${PUPPET_DNS_ALT_NAMES}" --no-daemonize --verbose
fi

echo "[RUN]: Builtin command not provided [puppetmaster]"
echo "[RUN]: $@"

exec "$@"
