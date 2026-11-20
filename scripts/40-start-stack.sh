#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOCKER_DIR="${SCRIPT_DIR}/../docker"

cd "${DOCKER_DIR}"

if [ ! -f .env ]; then
    echo "ERROR: docker/.env does not exist."
    echo
    echo "Create it first:"
    echo "    cp docker/.env.example docker/.env"
    echo
    echo "Then configure HOME_DOMAIN."
    exit 1
fi

echo "Validating configuration..."
docker compose config --quiet

echo "Building images..."
docker compose build

echo "Starting stack..."
docker compose up -d

echo
docker compose ps

# so that there will be no errors if example users.yml file is not renamed and edited
if [ ! -f "${DOCKER_DIR}/dozzle/users.yml" ]; then
    echo "ERROR: docker/dozzle/users.yml does not exist."
    echo
    echo "Create it first:"
    echo "  cp docker/dozzle/users.yml.example docker/dozzle/users.yml"
    exit 1
fi
