FROM emmercm/libtorrent:1.1@sha256:c320d63c943f723501f4a04e1d364b37548d6214e119181d082e59c232d5ff26

ARG FLEXGET_VERSION=3.1.21
ENV FLEXGET_VERSION=$FLEXGET_VERSION

ARG PYTHON_VERSION=3
ENV PYTHON_VERSION=$PYTHON_VERSION

ENV FLEXGET_PASSWORD=flexgetindocker

SHELL ["/bin/ash", "-euo", "pipefail", "-c"]

# Install FlexGet
#   https://pillow.readthedocs.io/en/stable/installation.html
# hadolint ignore=DL3003,DL3018,SC2169
RUN apk --update add --no-cache                              g++ gcc python3 && \
    apk --update add --no-cache --virtual build-dependencies jpeg-dev musl-dev python3-dev zlib-dev && \
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
