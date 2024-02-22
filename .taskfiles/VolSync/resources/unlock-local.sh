#!/usr/bin/env bash
set -e

VAULT=$1
ITEM=$2

get_value() {
  local vault="$1"
  local item="$2"
  local field="$3"

  op item get --vault "${vault}" "${item}" --fields "${field}"
}



export AWS_ACCESS_KEY_ID=$(get_value "$VAULT" "$ITEM" MINIO_ACCESS_KEY_ID)
export AWS_SECRET_ACCESS_KEY=$(get_value "$VAULT" "$ITEM" MINIO_SECRET_ACCESS_KEY)
export RESTIC_REPOSITORY=$(get_value "$VAULT" "$ITEM" MINIO_RESTIC_REPOSITORY)
export RESTIC_PASSWORD=$(get_value "$VAULT" "$ITEM" RESTIC_PASSWORD)

restic unlock --remove-all
