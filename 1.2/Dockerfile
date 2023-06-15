FROM emmercm/libtorrent:1.1@sha256:783f219df47662f569046f43d9e2414f05d01acf5247b9d5667cfb259784c6c3

ARG FLEXGET_VERSION=1.2.521
ENV FLEXGET_VERSION=$FLEXGET_VERSION

ARG PYTHON_VERSION=2
ENV PYTHON_VERSION=$PYTHON_VERSION

ENV FLEXGET_PASSWORD=flexgetindocker

SHELL ["/bin/ash", "-euo", "pipefail", "-c"]

# Install FlexGet
# hadolint ignore=DL3003,DL3018,SC2169,SC3060
RUN apk --update add --no-cache                              python2 py2-pip && \
    apk --update add --no-cache --virtual build-dependencies g++ gcc musl-dev python2-dev && \
    pip${PYTHON_VERSION/2/} install --upgrade pip && \
    pip${PYTHON_VERSION/2/} install flexget~=${FLEXGET_VERSION} "Flask<0.11" "Flask-Cors<3.0" "Flask-Login<0.4" "guessit<3.0" "html5lib<0.99999999" "pytvmaze<2.0" "rebulk<3.0.0" "SQLAlchemy<1.4.0" "Werkzeug<1.0.0" && \
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
