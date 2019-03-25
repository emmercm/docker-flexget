#!/usr/bin/env sh
set -euo pipefail


# Remove config lock
if [[ -f /config/.config-lock ]]; then
    rm /config/.config-lock
fi

# Keep FlexGet updated
pip3 install --upgrade --quiet flexget~=${VERSION}

# Default FlexGet config
if [[ ! -f /config/config.yml ]]; then
    cp /flexget.yml /config/config.yml
fi

# Set web UI password
flexget web passwd ${PASSWORD}

exec "$@"
