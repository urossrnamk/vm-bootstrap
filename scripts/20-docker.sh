#!/usr/bin/env bash

set -euo pipefail

echo "Installing Docker dependencies..."
dnf install -y dnf-plugins-core

echo "Adding Docker repository..."
dnf config-manager --add-repo \
    https://download.docker.com/linux/rhel/docker-ce.repo

echo "Installing Docker Engine..."
dnf install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

echo "Enabling Docker..."
systemctl enable --now docker

echo "Verifying Docker installation..."
docker --version
docker compose version

echo "Docker installed successfully."
