#!/usr/bin/env bash

. /var/lib/orches/repo/scripts/utils.sh

podman_secret Pangolin "Admin E-mail" pangolin-admin-email
podman_secret Pangolin "Admin Password" pangolin-admin-password
check_op_token
mkdir /var/tmp/pangolin
$OP_PODMAN --volume /var/lib/orches/repo/pangolin:/pangolin:ro,z --volume /var/tmp/pangolin:/pangolin/tmp:z $OP_IMAGE op inject --in-file /pangolin/templates/config.yml \
  --out-file /pangolin/tmp/config.yml
mv /var/tmp/pangolin/config.yml /var/lib/orches/repo/pangolin/config/config.yml
rm -r /var/tmp/pangolin
