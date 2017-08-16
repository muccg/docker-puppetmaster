FROM buildpack-deps:jessie-curl
LABEL maintainer "https://github.com/muccg/"

ARG ARG_PUPPET_VERSION
ARG ARG_LIBRARIAN_PUPPET_VERSION

ENV PUPPET_VERSION $ARG_PUPPET_VERSION
ENV LIBRARIAN_PUPPET_VERSION $ARG_LIBRARIAN_PUPPET_VERSION

RUN addgroup --gid 1000 puppet \
    && adduser --disabled-password --home /data --no-create-home --system -q --uid 1000 --ingroup puppet puppet \
    && mkdir /data \
    && chown puppet:puppet /data

RUN apt-get update && apt-get install -qy --no-install-recommends \
    git \
    ruby \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo "gem: --no-ri --no-rdoc" > ~/.gemrc
RUN gem install puppet -v ${PUPPET_VERSION}
RUN gem install librarian-puppet -v ${LIBRARIAN_PUPPET_VERSION}

VOLUME /data

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

USER puppet
ENV HOME /data
WORKDIR /data

EXPOSE 8140

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["puppetmaster"]
