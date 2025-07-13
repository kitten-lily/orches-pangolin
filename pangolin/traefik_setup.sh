#!/usr/bin/env bash

. /var/lib/orches/repo/scripts/utils.sh

mkdir -p /var/lib/orches/repo/pangolin/config/traefik/logs
mkdir -p /var/lib/orches/repo/pangolin/config/letsencrypt

podman_secret Pangolin "Cloudflare Token" pangolin-cloudflare-token
podman_secret Pangolin "Domain Name" pangolin-domain-name
