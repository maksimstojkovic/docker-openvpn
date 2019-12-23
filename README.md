# OpenVPN Docker Server Menu

[![Build Status](https://github.com/silentdigit/docker-openvpn/workflows/docker%20build/badge.svg)](https://github.com/silentdigit/docker-openvpn)
[![Docker Pulls](https://img.shields.io/docker/pulls/silentdigit/nextcloudpi)](https://hub.docker.com/repository/docker/silentdigit/openvpn)
[![Docker Stars](https://img.shields.io/docker/stars/silentdigit/nextcloudpi)](https://hub.docker.com/repository/docker/silentdigit/openvpn)
[![Image Size](https://images.microbadger.com/badges/image/silentdigit/openvpn.svg)](https://hub.docker.com/repository/docker/silentdigit/openvpn)
[![Image Version](https://images.microbadger.com/badges/version/silentdigit/openvpn.svg)](https://hub.docker.com/repository/docker/silentdigit/openvpn)
[![Image Commit](https://images.microbadger.com/badges/commit/silentdigit/openvpn.svg)](https://github.com/silentdigit/docker-openvpn)

Bash menu for managing an OpenVPN Docker server. This repository provides a console interface for using [`silentdigit/openvpn`](https://hub.docker.com/repository/docker/silentdigit/openvpn) which supports all major linux architectures.

The menu provides functionality for initialising a Certificate Authority (CA), issuing user certificates, generating a minimal set of server files which excludes the CA root key, and encryption of vulnerable CA files.

## Running the Menu

The menu assumes that CA and server files will be generated in the current working directory (`$PWD`). Navigating to a removable media device before starting the menu is recommended to increase security.

Start the menu using:

```
bash <path-to-repo>/menu/ovpn_menu
```

## Features

Initialising the CA automatically generates:

- Diffie-Hellman parameters
- A private key
- A self-certificate matching the private key for the OpenVPN server
- An EasyRSA CA key and certificate
- A TLS auth key from HMAC security

## Security

When not using the CA to manage user certificates, it is recommended that CA files are encrypted and stored offline on removable media devices. This can be done using `5) Manage Server -> 6) Encrypt CA` and `5) Manage Server -> 7) Decrypt CA`.
