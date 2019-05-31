ARG BASE_IMAGE=emmercm/libtorrent:latest

FROM ${BASE_IMAGE}

ENV VERSION=2.0
ENV PASSWORD=flexgetindocker

COPY entrypoint.sh flexget.yml variables.yml /

# Install FlexGet
RUN set -euo pipefail && \
    # Install FlexGet and all dependencies
    apk --update add --no-cache python3 && \
    pip3 install --upgrade pip && \
    pip3 install flexget~=${VERSION} && \
    # Make directories, and symlink them for quality of life
    mkdir ~/.flexget && \
    ln -s ~/.flexget /config && \
    # Install container and entrypoint dependencies
    apk --update add --no-cache dumb-init tzdata

VOLUME ["/config"]

EXPOSE 5050

ENTRYPOINT ["dumb-init", "/entrypoint.sh"]

CMD ["flexget", "--loglevel", "info", "daemon", "start", "--autoreload-config"]
