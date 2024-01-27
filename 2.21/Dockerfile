FROM emmercm/libtorrent:1.1@sha256:29f69d46b57d5494ba341b03641e9a706007fc00186dc8f363d5035e84b67eb1

ARG FLEXGET_VERSION=2.21.35
ENV FLEXGET_VERSION=$FLEXGET_VERSION

ARG PYTHON_VERSION=3
ENV PYTHON_VERSION=$PYTHON_VERSION

ENV FLEXGET_PASSWORD=flexgetindocker

SHELL ["/bin/ash", "-euo", "pipefail", "-c"]

# Install FlexGet
# hadolint ignore=DL3003,DL3018,SC2169,SC3060
RUN apk --update add --no-cache python3 && \
    pip${PYTHON_VERSION/2/} install --upgrade "pip<23.1" "setuptools<46" && \
    pip${PYTHON_VERSION/2/} install flexget~=${FLEXGET_VERSION} && \
    # Fix Python 3.8+
    find /usr/lib/python3*/site-packages/flexget -type f -name "*" -print0 | xargs -0 sed -i 's/from future.moves import/import/g' && \
    find /usr/lib/python3*/site-packages/flexget -type f -name "*" -print0 | xargs -0 sed -i 's/from future.moves./from /g' && \
    # Make directories, and symlink them for quality of life
    mkdir ~/.flexget && \
    ln -s ~/.flexget /config && \
    # Install container and entrypoint dependencies
    apk --update add --no-cache dumb-init tzdata && \
    # Remove temp files
    cd && \
    rm -rf /tmp/*

COPY entrypoint.sh flexget.yml /

VOLUME ["/config"]

EXPOSE 5050

ENTRYPOINT ["dumb-init", "/entrypoint.sh"]

CMD ["flexget", "--loglevel", "info", "daemon", "start", "--autoreload-config"]
