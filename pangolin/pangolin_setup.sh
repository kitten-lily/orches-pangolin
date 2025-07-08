#!/usr/bin/env bash

. /var/lib/orches/repo/scripts/utils.sh

podman_secret Pangolin "Admin E-mail" pangolin-admin-email
podman_secret Pangolin "Admin Password" pangolin-admin-password
check_op_token
$OP inject --in-file pangolin/templates/config.yml \
  --out-file pangolin/config/config.yml \
  --force
