#!/usr/bin/env sh
set -euo pipefail


# Keep FlexGet updated
pip3 install --upgrade flexget~=${VERSION}

# Default FlexGet config
if [[ ! -f /config/config.yml ]]; then
    cp /flexget.yml /config/config.yml
fi

flexget daemon start --autoreload-config
