#!/usr/bin/env sh
set -euo pipefail


# Remove config lock
if [[ -f /config/.config-lock ]]; then
    rm /config/.config-lock
fi

# Python 3 fix
find /usr/lib/python3*/site-packages/flexget -type f -name "*" -print0 | xargs -0 sed -i 's/future.moves.urllib/urllib/g'

# Default FlexGet config
if [[ ! -f /config/config.yml ]]; then
    cp /flexget.yml /config/config.yml
fi

# Set web UI password
flexget web passwd ${FLEXGET_PASSWORD}

exec "$@"
