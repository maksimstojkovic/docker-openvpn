# OpenVPN Docker Server Menu

[![Build Status](https://github.com/maksimstojkovic/docker-openvpn/workflows/docker%20build/badge.svg)](https://github.com/maksimstojkovic/docker-openvpn)
[![Docker Pulls](https://img.shields.io/docker/pulls/maksimstojkovic/openvpn)](https://hub.docker.com/repository/docker/maksimstojkovic/openvpn)
[![Docker Stars](https://img.shields.io/docker/stars/maksimstojkovic/openvpn)](https://hub.docker.com/repository/docker/maksimstojkovic/openvpn)
[![Image Size](https://images.microbadger.com/badges/image/maksimstojkovic/openvpn.svg)](https://hub.docker.com/repository/docker/maksimstojkovic/openvpn)
[![Image Version](https://images.microbadger.com/badges/version/maksimstojkovic/openvpn.svg)](https://hub.docker.com/repository/docker/maksimstojkovic/openvpn)
[![Image Commit](https://images.microbadger.com/badges/commit/maksimstojkovic/openvpn.svg)](https://github.com/maksimstojkovic/docker-openvpn)

Bash menu for managing an OpenVPN Docker server. This repository provides a console interface for using [`maksimstojkovic/openvpn`](https://hub.docker.com/repository/docker/maksimstojkovic/openvpn) which supports all major linux architectures.

The menu provides functionality for initialising a Certificate Authority (CA), issuing user certificates, generating a minimal set of server files which excludes the CA root key, and encryption of vulnerable CA files.

## Running the Menu

The menu assumes that CA and server files will be generated in the current working directory (`$PWD`). Navigating to a removable media device before starting the menu is recommended to increase security.

Start the menu using:

```
sudo bash <path-to-repo>/menu/ovpn_menu
```

To increase security, manage the CA Root Key on another device (not the VPN server), i.e. on removable media. This device will be used for generating certificates only, with vulnerable files (especially private keys) being kept offline when not in use (keys are effectively generated on one device and used on another, where the second device lacks the files necessary to create new keys). To implement this, use the following procedure, where *Device A* is the certificate generating device and *Device B* is the VPN server:

1. Using *Device A*, clone the repo onto a removable media device.
2. Navigate to the cloned repo and run `init-server <vpn-domain>`.
3. Enter your `<vpn-domain>` when asked and use a strong password to secure the CA Root Key (weak passwords are known to cause errors).
4. Generate certificates for any clients that will connect to the VPN server using `create-cert <user>`, entering a password for the `<user>` specified and the CA Root Key password when required.
5. Export the CA server files from *Device A* using `gen-ca-server-files` (exported files are stored in `openvpn-data/server`).
6. Clone the repo on *Device B* and copy the files from `openvpn-data/server` on *Device A* to a new directory named `openvpn-data` on *Device B* (e.g. using `scp`)
7. Retrieve the client certificates using `get-cert <user>` and install it on client devices.
8. Start the server using `start-server` and connect to the VPN server.

NOTE: To make devices on the server's local network accessible to VPN clients, include the following in the menu's optional arguments section (`xxx.xxx.xxx.0` is the server network subnet, e.g. `192.168.1.0`):

```
-p route xxx.xxx.xxx.0 255.255.255.0
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
