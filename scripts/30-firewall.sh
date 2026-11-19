#!/usr/bin/env bash

set -euo pipefail

systemctl enable --now firewalld

firewall-cmd --permanent --add-service=http
firewall-cmd --permanent --add-service=https

firewall-cmd --reload