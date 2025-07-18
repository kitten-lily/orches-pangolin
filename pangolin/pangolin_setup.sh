#!/usr/bin/env bash

. /var/lib/orches/repo/scripts/utils.sh

podman_secret Pangolin "Admin E-mail" pangolin-admin-email
podman_secret Pangolin "Admin Password" pangolin-admin-password

if [ ! -f "/var/lib/orches/repo/pangolin/config/config.yml" ]; then
    $OP_PODMAN --user root --volume /var/lib/orches/repo/pangolin/templates/config.yml:/template.yml \
    --volume /var/lib/orches/repo/pangolin/config:/config \
    $OP_IMAGE op inject --in-file /template.yml  --out-file /config/config.yml --force
fi
