#!/usr/bin/env bash

. /var/lib/orches/repo/scripts/utils.sh

podman_secret Pangolin "Admin E-mail" pangolin-admin-email
podman_secret Pangolin "Admin Password" pangolin-admin-password
check_op_token
$OP_PODMAN --volume ./pangolin:/pangolin:z $OP_IMAGE op inject --in-file pangolin/templates/config.yml \
  --out-file pangolin/config/config.yml \
  --force
