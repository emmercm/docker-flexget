#!/usr/bin/env sh
set -euo pipefail


# Remove config lock
if [[ -f /config/.config-lock ]]; then
    rm /config/.config-lock
fi

# Keep FlexGet updated
echo "Checking for FlexGet updates ..."
pip${PYTHON_VERSION/2/} install --upgrade --quiet pip
pip${PYTHON_VERSION/2/} install --upgrade --quiet flexget~=${FLEXGET_VERSION}

# Default FlexGet config
if [[ ! -f /config/config.yml && -f /flexget.yml ]]; then
    cp /flexget.yml /config/config.yml
fi

# Set web UI password
flexget web passwd ${FLEXGET_PASSWORD}

exec "$@"
