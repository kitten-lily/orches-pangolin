#!/usr/bin/env bash

. /var/lib/orches/repo/scripts/utils.sh

podman_secret Pangolin "Cloudflare Token" pangolin-cloudflare-token
podman_secret Pangolin "Domain Name" pangolin-domain-name
