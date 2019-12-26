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

# Python 3 fix
find /usr/lib/python3*/site-packages/flexget -type f -name "*" -print0 | xargs -0 sed -i 's/future.moves.urllib/urllib/g'

# Default FlexGet config
if [[ ! -f /config/config.yml ]]; then
    cp /flexget.yml /config/config.yml
fi

# Set web UI password
flexget web passwd ${FLEXGET_PASSWORD}

exec "$@"
