FROM emmercm/libtorrent:1.1@sha256:bf2b211015403180e2da8d08d5cf0d2b3b63ae1ae9af1f099bfb4d3438d9c796

ARG FLEXGET_VERSION=1.2.521
ENV FLEXGET_VERSION=$FLEXGET_VERSION

ARG PYTHON_VERSION=2
ENV PYTHON_VERSION=$PYTHON_VERSION

ENV FLEXGET_PASSWORD=flexgetindocker

SHELL ["/bin/ash", "-euo", "pipefail", "-c"]

# Install FlexGet
# hadolint ignore=DL3003,DL3018,SC2169
RUN apk --update add --no-cache                              python2 py2-pip && \
    apk --update add --no-cache --virtual build-dependencies g++ gcc musl-dev python2-dev && \
    pip${PYTHON_VERSION/2/} install --upgrade pip && \
    pip${PYTHON_VERSION/2/} install flexget~=${FLEXGET_VERSION} "Flask<0.11" "Flask-Cors<3.0" "Flask-Login<0.4" "guessit<3.0" "html5lib<0.99999999" "pytvmaze<2.0" && \
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
