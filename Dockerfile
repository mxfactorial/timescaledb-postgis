FROM timescale/timescaledb:latest-pg16
# adapted from https://github.com/timescale/timescaledb-docker/blob/d31d31a66626e9dc491a440aa1b74c0c37e2aa54/postgis/Dockerfile
ENV POSTGIS_VERSION 3.4.2

RUN set -ex \
    && apk add --no-cache --virtual .fetch-deps \
    ca-certificates \
    openssl \
    tar \
    && apk add --no-cache --virtual .build-deps \
    autoconf \
    automake \
    file \
    json-c-dev \
    libtool \
    libxml2-dev \
    make \
    perl \
    llvm15 \
    clang15 \
    clang15-dev \
    && apk add --no-cache --virtual .build-deps-edge \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
    g++ \
    gdal-dev \
    geos-dev \
    proj-dev \
    protobuf-c-dev \
    && cd /tmp \
    && wget https://github.com/postgis/postgis/archive/${POSTGIS_VERSION}.tar.gz -O - | tar -xz \
    && chown root:root -R postgis-${POSTGIS_VERSION} \
    && cd /tmp/postgis-${POSTGIS_VERSION} \
    && ./autogen.sh \
    && ./configure \
    && echo "PERL = /usr/bin/perl" >> extensions/postgis/Makefile \
    && echo "PERL = /usr/bin/perl" >> extensions/postgis_topology/Makefile \
    && make -s \
    && make -s install \
    && apk add --no-cache --virtual .postgis-rundeps \
    json-c \
    && apk add --no-cache --virtual .postgis-rundeps-edge \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
    geos \
    gdal \
    proj \
    protobuf-c \
    libstdc++ \
    && cd / \
    && rm -rf /tmp/postgis-${POSTGIS_VERSION} \
    && apk del .fetch-deps .build-deps .build-deps-edge