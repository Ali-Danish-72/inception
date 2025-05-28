# Inception (42 Project)

## 🛠️ Overview

**Inception** is a system administration and DevOps project from the 42 curriculum. The objective is to virtualize and containerize a functional multi-service web infrastructure using Docker. This project was built using a Debian base image and configured manually from scratch using Dockerfiles.

This repository contains a fully containerized environment with multiple services communicating over a custom Docker network.

## 📦 Services

| Service     | Description                                                                 |
|-------------|-----------------------------------------------------------------------------|
| **NGINX**   | Reverse proxy server handling HTTPS requests with SSL (TLSv1.2+).          |
| **WordPress** | PHP-based CMS running behind NGINX with content stored in MariaDB.       |
| **MariaDB** | Relational database used by WordPress and accessible via Adminer.          |
| **VSFTPD**  | Secure FTP server with FTPS (SSL/TLS) support.                             |
| **Redis**   | In-memory key-value store used for WordPress object caching.               |
| **Adminer** | Lightweight web-based database management tool.                            |
| **Portainer** | Web UI for Docker container management and visualization.               |
| **Static Webpage** | A simple static HTML page served by NGINX as a custom webpage. |

## 🔐 Security

- All web services are served via **HTTPS** using self-signed SSL certificates.
- Anonymous FTP login is **disabled**; users are authenticated and jailed to their directories.
- Access to the Docker socket for Portainer is restricted to allow container-level management only.

## 🔧 Key Features

- Custom Docker network and volumes for persistent data.
- Self-signed certificates generated dynamically in containers.
- PHP-FPM used for both WordPress and Adminer.
- NGINX configured with two separate server blocks for WordPress and Adminer.
- WordPress can be accessed directly or after visiting the static landing page.

## 🚀 Usage

To build and run the infrastructure:

```bash
git clone https://github.com/Ali-Danish-72/inception && cd inception && make
