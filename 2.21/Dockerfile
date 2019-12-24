FROM emmercm/libtorrent:1.1.13@sha256:869d85b6e539b429c3ffaeb5c159cc8fa717c36733e4f9442ce83e49c3cccd55

ARG FLEXGET_VERSION=2.21.35
ENV FLEXGET_VERSION=$FLEXGET_VERSION

ARG PYTHON_VERSION=3
ENV PYTHON_VERSION=$PYTHON_VERSION

ENV FLEXGET_PASSWORD=flexgetindocker

# Install FlexGet
RUN set -euo pipefail && \
    # Install FlexGet and all dependencies
    apk --update add --no-cache python3 && \
    pip${PYTHON_VERSION/2/} install --upgrade pip && \
    pip${PYTHON_VERSION/2/} install flexget~=${FLEXGET_VERSION} && \
    # Make directories, and symlink them for quality of life
    mkdir ~/.flexget && \
    ln -s ~/.flexget /config && \
    # Install container and entrypoint dependencies
    apk --update add --no-cache dumb-init tzdata

COPY entrypoint.sh flexget.yml /

VOLUME ["/config"]

EXPOSE 5050

ENTRYPOINT ["dumb-init", "/entrypoint.sh"]

CMD ["flexget", "--loglevel", "info", "daemon", "start", "--autoreload-config"]
