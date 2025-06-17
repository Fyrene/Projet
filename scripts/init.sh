#!/bin/bash

# Initialize environment files and volumes for the security lab
set -euo pipefail

SERVICES=(Iris Shuffle misp suricata-zeek wazuh-docker-main)

# Copy global environment file
if [ -f .env.example ] && [ ! -f .env ]; then
  cp .env.example .env
  echo "Created .env"
fi

for svc in "${SERVICES[@]}"; do
  example="$svc/.env.example"
  target="$svc/.env"
  if [ -f "$example" ] && [ ! -f "$target" ]; then
    cp "$example" "$target"
    echo "Created $target"
  fi
done

# Ensure persistent directories exist
mkdir -p volumes/shuffle-database

# Generate Wazuh Indexer certificates if missing
cert_dir="wazuh-docker-main/config/wazuh_indexer_ssl_certs"
if [ ! -d "$cert_dir" ] || [ -z "$(ls -A "$cert_dir" 2>/dev/null)" ]; then
  mkdir -p "$cert_dir"
  docker compose -f wazuh-docker-main/generate-indexer-certs.yml run --rm generator
fi
