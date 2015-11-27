FROM muccg/ubuntu14.04-base:latest
MAINTAINER https://github.com/muccg/

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -qy  --no-install-recommends \
   wget \
   && wget --no-check-certificate https://apt.puppetlabs.com/puppetlabs-release-trusty.deb \
   && dpkg -i puppetlabs-release-trusty.deb \
   && rm puppetlabs-release-trusty.deb

RUN apt-get update && apt-get install -qy  --no-install-recommends \
  puppetmaster \
  ruby \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN env --unset=DEBIAN_FRONTEND

VOLUME /data

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENV HOME /data
WORKDIR /data

EXPOSE 8140

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["puppetmaster"]
