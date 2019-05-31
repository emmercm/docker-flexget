#!/usr/bin/env sh
set -euo pipefail


# Remove config lock
if [[ -f /config/.config-lock ]]; then
    rm /config/.config-lock
fi

# Keep FlexGet updated
echo "Checking for FlexGet updates ..."
pip3 install --upgrade --quiet flexget~=${VERSION}

# Default FlexGet configs
# if [[ ! -f /config/config.yml ]]; then
    cp /flexget.yml /config/config.yml
# fi
# if [[ ! -f /config/variables.yml ]]; then
    cp /variables.yml /config/variables.yml
# fi

# Set web UI password
if [[ ! -z "${PASSWORD}" ]]; then
    flexget web passwd "${PASSWORD}"
fi

flexget trakt auth emmercm
flexget --loglevel verbose execute
flexget entry-list all
flexget entry-list list download
flexget series list

exec "$@"
