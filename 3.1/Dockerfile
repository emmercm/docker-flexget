FROM emmercm/libtorrent:1.1@sha256:0e55b3cfd95c811d98accd2476dfb9f6fd9d491834e6282dd8f5e23344a91e35

ARG FLEXGET_VERSION=3.1.21
ENV FLEXGET_VERSION=$FLEXGET_VERSION

ARG PYTHON_VERSION=3
ENV PYTHON_VERSION=$PYTHON_VERSION

ENV FLEXGET_PASSWORD=flexgetindocker

# Install FlexGet
RUN set -euo pipefail && \
    # Install FlexGet and all dependencies
    #   https://pillow.readthedocs.io/en/stable/installation.html
    apk --update add --no-cache                              python3 && \
    apk --update add --no-cache --virtual build-dependencies gcc jpeg-dev musl-dev python3-dev zlib-dev && \
    pip${PYTHON_VERSION/2/} install --upgrade pip && \
    pip${PYTHON_VERSION/2/} install flexget~=${FLEXGET_VERSION} && \
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
