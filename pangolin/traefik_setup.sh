#!/usr/bin/env bash

. /var/lib/orches/repo/scripts/utils.sh

mkdir -p /var/lib/orches/repo/pangolin/config/traefik/logs
mkdir -p /var/lib/orches/repo/pangolin/config/letsencrypt

podman_secret Pangolin "Porkbun API Key" pangolin-porkbun-api-key
podman_secret Pangolin "Porkbun Secret Key" pangolin-porkbun-secret-key
podman_secret Pangolin "Domain Name" pangolin-domain-name
