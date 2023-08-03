FROM emmercm/libtorrent:2.0@sha256:de408e0992d33595b2e267e925a58b69f659c84a61d2c00c599ca367c15948c0

ARG FLEXGET_VERSION=3.8.0
ENV FLEXGET_VERSION=$FLEXGET_VERSION

ARG PYTHON_VERSION=3
ENV PYTHON_VERSION=$PYTHON_VERSION

ENV FLEXGET_PASSWORD=flexgetindocker

SHELL ["/bin/ash", "-euo", "pipefail", "-c"]

# Install FlexGet
#   https://pillow.readthedocs.io/en/stable/installation.html
# hadolint ignore=DL3003,DL3018,SC2169,SC3060
RUN apk --update add --no-cache                              g++ gcc py3-pip python3 python3-dev && \
    apk --update add --no-cache --virtual build-dependencies jpeg-dev linux-headers musl-dev zlib-dev && \
    pip${PYTHON_VERSION/2/} install --upgrade pip && \
    pip${PYTHON_VERSION/2/} install --ignore-installed flexget~=${FLEXGET_VERSION} && \
    # Make directories, and symlink them for quality of life
    mkdir ~/.flexget && \
    ln -s ~/.flexget /config && \
    # Install container and entrypoint dependencies
    apk --update add --no-cache dumb-init tzdata && \
    # Remove temp files
    cd && \
    apk del --purge build-dependencies && \
    rm -rf /tmp/*

COPY entrypoint.sh flexget.yml /

VOLUME ["/config"]

EXPOSE 5050

ENTRYPOINT ["dumb-init", "/entrypoint.sh"]

CMD ["flexget", "--loglevel", "info", "daemon", "start", "--autoreload-config"]
