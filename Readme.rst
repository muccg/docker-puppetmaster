Docker Puppet master container
==============================

Confdir is set to /data, which is also exposed as a volume. It is intended to mount /data with your own config (puppet.conf, hiera.yaml and so on).

Running
-------

Example of typical usage::

    docker run \
           -h 'puppetmaster' --net bridge -m 0b --detach=true \
           -e PUPPET_DNS_ALT_NAMES="localhost,puppetmaster,puppermaster.somedomain" \
           -p 8140:8140 \
           -v /etc/localtime:/etc/localtime:ro \
           -v /data/puppetmaster:/data  \
           --name puppetmaster \
           muccg/puppetmaster:3.8.7 \
           puppetmaster

Versions
--------

3.8.7 Debian Jessie, Puppet from gems, puppet user

3.8.4 Ubuntu 14.04, Puppet from APT, running as root

Latest is completely misleading (sorry about that), it is 3.8.4 and will be deprecated in the future.
