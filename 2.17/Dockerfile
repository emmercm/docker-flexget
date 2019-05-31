FROM emmercm/libtorrent:1.2.1@sha256:0175a8baf5665626bacaed0dd89961f3fda3747909931a267605198bedbb6d24

ENV VERSION=2.17.0
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
