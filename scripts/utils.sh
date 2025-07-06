#!/usr/bin/env bash

TOKEN_FILE="/var/lib/orches/.op-token"
VAULT="${HOSTNAME^}"
OP=/home/linuxbrew/.linuxbrew/bin/op

# Check if 1Password Service Account Token is set
check_op_token() {
  # Verify that the 1Password Service Account Token is set
  if [[ ! -f $TOKEN_FILE ]]; then
    echo "ERROR: $TOKEN_FILE does not exist."
    echo "Please run the op_token function to create it."
    exit 1
  fi

  . $TOKEN_FILE

  if [[ -z "${OP_SERVICE_ACCOUNT_TOKEN}" ]]; then
    echo "ERROR: OP_SERVICE_ACCOUNT_TOKEN environment variable is not set"
    echo "Please use the op_token function to set it up."
    exit 1
  fi
}

# Create podman secret from 1Password item
podman_secret() {
  local ITEM="$1"
  local FIELD="$2"
  local SECRET_NAME="$3"

  if [[ -z "$ITEM" || -z "$FIELD" || -z "$SECRET_NAME" ]]; then
    echo "Error: podman_secret requires three arguments: ITEM FIELD SECRET_NAME"
    return 1
  fi

  # Check if secret already exists
  if podman secret exists "$SECRET_NAME"; then
    return 0
  fi

  check_op_token
  OP_SERVICE_ACCOUNT_TOKEN=$OP_SERVICE_ACCOUNT_TOKEN \
  $OP item get "$ITEM" --vault "$VAULT" --fields "$FIELD" --reveal --format json | \
  echo -n $(jq -r '.value') | \
  podman secret create "$SECRET_NAME" - > /dev/null
}

# Function to set up Newt secrets for a service
newt_secrets() {
  local SERVICE="$1"

  if [[ -z "$SERVICE" ]]; then
    echo "ERROR: Service name is required."
    echo "Usage: newt_secrets SERVICE"
    return 1
  fi

  podman_secret "${SERVICE}" "Pangolin Endpoint" "${SERVICE}-pangolin-endpoint" || return 1
  podman_secret "${SERVICE}" "Newt ID" "${SERVICE}-newt-id" || return 1
  podman_secret "${SERVICE}" "Newt Secret" "${SERVICE}-newt-secret" || return 1
}
