# PufferPanel-Cloudflare-Tunnel Script (Updated)

**Owner:** IN3PIRE

This repository provides an automated Bash script to install **PufferPanel 3.x** on Ubuntu and expose it publicly via **Cloudflare Tunnel (cloudflared)**. The previous version used the now‑defunct Serveo service; this version updates the installation process and documentation accordingly.

## Overview

The script performs the following steps:
1. Installs required system dependencies (including `cloudflared`).
2. Adds the official PufferPanel APT repository and installs the latest PufferPanel package.
3. Prompts the user for an admin username and password and creates the admin account.
4. Sets up a Cloudflare Tunnel that forwards `localhost:8080` (PufferPanel's default port) to a public `*.trycloudflare.com` URL.
5. Starts and enables both the `pufferpanel` and `cloudflared` services.

## Prerequisites

- Ubuntu 20.04+ (the script uses `apt` and `systemd`).
- Root privileges (run with `sudo` or as the root user).
- A **Cloudflare account**. The first time the script runs, you will be prompted to log in to Cloudflare to authorize `cloudflared`.

## Installation

```bash
# Clone the repository
git clone https://github.com/IN3PIRE/PufferPanel-Serveo-Script.git

# Change into the directory
cd PufferPanel-Serveo-Script

# Checkout the updated branch (optional if you are on the main branch)
git checkout feat/update-installation

# Make the script executable
chmod +x start.sh
```

## Usage

```bash
# Run the script (as root or with sudo)
sudo ./start.sh
```

The script will ask you to choose a game server type (e.g., `minecraft`, `nodejs`, or `python`). This choice currently only determines which PufferPanel template will be used later.

After the installation completes you will see a message similar to:
```
Tunnel established. Access your PufferPanel via the generated *.trycloudflare.com URL.
```
Open that URL in a web browser, log in with the admin credentials you provided, and you are ready to manage your game servers.

## Features
- **Automated PufferPanel 3.x installation** using the official package repository.
- **Secure public exposure** via Cloudflare Tunnel (no need for port forwarding or VPN).
- **Root‑only execution** with strict error handling (`set -euo pipefail`).
- **Interactive admin credential setup**.

## Notes & Recommendations
- After the initial setup, review PufferPanel's security settings (e.g., enable HTTPS, configure a firewall, change the default admin email).
- Cloudflare Tunnel creates a temporary URL; you can create a permanent sub‑domain in your Cloudflare dashboard if desired.
- The script currently installs `openjdk-17-jre-headless`; adjust the Java version if your games require a different runtime.

## Contributing
Contributions are welcome! Feel free to open issues or submit pull requests for improvements, additional tunneling options, or support for other distributions.

## License
This project is licensed under the MIT License – see the [LICENSE](LICENSE) file for details.
