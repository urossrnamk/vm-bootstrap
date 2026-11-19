#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "Starting VM bootstrap..."
echo

for script in scripts/[0-9][0-9]-*.sh; do
    echo "========================================"
    echo "Running: $script"
    echo "========================================"

    bash "$script"

    echo
done

echo "========================================"
echo "VM bootstrap complete"
echo "========================================"