#!/usr/bin/env bash

. /var/lib/orches/repo/scripts/utils.sh

podman_secret Pangolin "Admin E-mail" pangolin-admin-email
podman_secret Pangolin "Admin Password" pangolin-admin-password
check_op_token
mkdir /var/tmp/pangolin
$OP_PODMAN --user root --volume /var/lib/orches/repo/pangolin:/pangolin:z --volume /var/tmp/pangolin:/pangolin/tmp:z $OP_IMAGE op inject --in-file /pangolin/templates/config.yml \
  --out-file /pangolin/tmp/config.yml --force
