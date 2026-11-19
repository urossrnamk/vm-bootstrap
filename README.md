# VM Bootstrap

Bootstrap configuration for R&D VMs.

## Target environment

- AlmaLinux 10
- Docker
- Traefik
- `*.test.example.com`
- Applications deployed as Docker containers

## Prerequisites

A fresh VM requires:

- SSH access
- Internet access
- GitHub deploy key with read access to this repository
- DNS pointing `*.test.example.com` to the VM
- TCP 80 and 443 allowed to the VM

## Initial setup

Log into the fresh VM as root.

### 1. Install Git

    dnf install -y git

### 2. Configure GitHub SSH access

The VM uses its own SSH key for read-only access to the bootstrap
repository. Do not reuse a personal SSH key.

#### Generate the SSH key

Create the SSH directory if necessary:

    mkdir -p /root/.ssh
    chmod 700 /root/.ssh

Generate a dedicated ED25519 key:

    ssh-keygen -t ed25519 -f /root/.ssh/github-vm-bootstrap -C "domenca-sandbox | vm-bootstrap | GitHub | 2026-11"

This creates:

    /root/.ssh/github-vm-bootstrap       # private key - DO NOT SHARE
    /root/.ssh/github-vm-bootstrap.pub   # public key

Display the public key:

    cat /root/.ssh/github-vm-bootstrap.pub

Add this public key to the GitHub repository as a read-only Deploy Key.

#### Configure SSH

Create:

    vi /root/.ssh/config

Add:

    Host github.com
        HostName ssh.github.com
        Port 443
        User git
        IdentityFile ~/.ssh/github-vm-bootstrap
        IdentitiesOnly yes

Set permissions:

    chmod 600 /root/.ssh/config
    chmod 600 /root/.ssh/github-vm-bootstrap
    chmod 644 /root/.ssh/github-vm-bootstrap.pub

The resulting setup should be:

    /root/.ssh/
    ├── config
    ├── github-vm-bootstrap
    └── github-vm-bootstrap.pub

#### Test GitHub access

    ssh -T git@github.com

GitHub SSH is configured to use port 443 because outbound SSH
on the standard port 22 may be blocked by the corporate network.

### 3. Clone bootstrap repository

    mkdir -p /srv
    cd /srv
    git clone git@github.com:COMPANY/vm-bootstrap.git

### 4. Bootstrap the server

    cd /srv/vm-bootstrap
    ./bootstrap.sh


## What the bootstrap does

1. Updates AlmaLinux
2. Installs base administration tools
3. Installs Docker Engine and Compose
4. Configures firewalld
5. Creates the shared proxy Docker network
6. Starts the Apache reverse proxy
7. Starts the R&D landing page
8. Starts the PHP test application


## Not managed by bootstrap.sh

The following are infrastructure/provider concerns:

- VM creation
- CPU/RAM/disk sizing
- CloudStack networking
- CloudStack ingress rules
- public IP assignment
- DNS records
- initial SSH access
- GitHub deploy-key registration

### Configure the host domain

Create the local Docker environment configuration:

    cd /srv/vm-bootstrap
    cp docker/.env.example docker/.env

Edit:

    vi docker/.env

Set the domain assigned to this host:

    HOME_DOMAIN=test.example.com

DNS should contain records equivalent to:

    test.example.com      → server IP
    *.test.example.com    → server IP

The bootstrap stack will initially provide:

    HOME_DOMAIN                  → home page
    hello.HOME_DOMAIN            → PHP test application