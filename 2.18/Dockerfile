FROM emmercm/libtorrent:1.1.13@sha256:43824cf3619dc5ac2db7dd9340c7bc5a436e40fca06b2dae6f8a05a1e2b6bdc6

ENV VERSION=2.18.0
ENV PASSWORD=flexgetindocker

COPY entrypoint.sh flexget.yml /

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
