#!/usr/bin/env bash

. /var/lib/orches/repo/scripts/utils.sh

TEMPLATE_PATH="/var/lib/orches/repo/pangolin/templates/config.yml"
CONFIG_PATH="/var/lib/orches/repo/pangolin/config"

podman_secret Pangolin "Admin E-mail" pangolin-admin-email
podman_secret Pangolin "Admin Password" pangolin-admin-password

if [ ! -f "/var/lib/orches/repo/pangolin/config/config.yml" ]; then
    $OP_PODMAN --user root --volume $TEMPLATE_PATH:/template.yml \
    --volume $CONFIG_PATH:/config \
    $OP_IMAGE op inject --in-file /template.yml  --out-file /config/config.yml --force
fi
