#!/usr/bin/env bash

set -euo pipefail

dnf update -y

dnf install -y \
    git \
    curl \
    wget \
    vim \
    rsync \
    unzip