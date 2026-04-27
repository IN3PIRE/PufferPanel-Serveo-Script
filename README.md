# PufferPanel‑Cloudflare‑Tunnel Script (Ubuntu)

**Owner:** IN3PIRE  

This repository provides an automated Bash script that installs **PufferPanel 3.x** on Ubuntu and makes it publicly reachable via a **Cloudflare Tunnel (cloudflared)**.  
The original version used the now‑defunct Serveo service; this updated version replaces it with the reliable, free Cloudflare Tunnel and follows the latest PufferPanel installation procedure.

---  

## Overview  

The script performs the following actions automatically:

1. **Installs required system packages** (including `cloudflared`).  
2. **Adds the official PufferPanel APT repository** and installs the latest PufferPanel package.  
3. **Prompts for admin credentials** and creates the admin user.  
4. **Creates a Cloudflare Tunnel** that forwards `localhost:8080` (PufferPanel’s default port) to a public `*.trycloudflare.com` URL.  
5. **Enables & starts** both `pufferpanel` and `cloudflared` services.  

Result: a fully‑functional PufferPanel instance reachable from anywhere without opening firewall ports or configuring a reverse proxy.

---  

## Prerequisites  

| Requirement | Reason |
|-------------|--------|
| **Ubuntu 20.04+** (or any recent Debian‑based distro) | The script uses `apt` and `systemd`. |
| **Root / sudo** | Installation of packages and services requires elevated privileges. |
| **Cloudflare account** | `cloudflared` must authenticate to Cloudflare the first time it runs. |
| **Internet connectivity** | Needed to download packages and the Cloudflare binary. |

---  

## Installation  

```bash
# 1. Clone the repo
git clone https://github.com/IN3PIRE/PufferPanel-Serveo-Script.git
cd PufferPanel-Serveo-Script

# 2. (Optional) switch to the latest development branch
git checkout feat/update-installation   # ← already the default on main

# 3. Make the script executable
chmod +x start.sh
```

---  

## Usage  

```bash
# Run the script as root (or with sudo)
sudo ./start.sh
```

The script will:

1. Ask you to pick a **game‑server type** (`minecraft`, `nodejs`, or `python`).  
   This only influences which PufferPanel template will be selected later.  

2. Prompt for an **admin username** and **admin password**.  

3. Install PufferPanel and configure the admin account.  

4. Create a **Cloudflare Tunnel**. On the first run you’ll be asked to log in to Cloudflare in the terminal.  

When the process finishes you’ll see a message similar to:

```
Tunnel established. Access your PufferPanel via the generated *.trycloudflare.com URL.
```

Open that URL in a browser, log in with the credentials you supplied, and you’re ready to manage your game servers.

---  

## Features  

- **Up‑to‑date PufferPanel installation** using the official package repository (v3.x).  
- **Secure public exposure** via Cloudflare Tunnel – no port‑forwarding, NAT, or VPN needed.  
- **Strict Bash safety** (`set -euo pipefail`) and root‑user verification.  
- **Interactive admin setup** with hidden password entry.  
- **Systemd integration** – both `pufferpanel` and `cloudflared` are enabled to start on boot.  

---  

## Security & Post‑Installation Recommendations  

- Change the placeholder admin e‑mail (`admin@in3pire.com`) to a real address.  
- Consider enabling HTTPS on the PufferPanel UI (e.g., via a reverse proxy or Cloudflare SSL).  
- Review firewall rules; even though the tunnel handles inbound traffic, outbound traffic should be limited to what you need.  
- Keep both PufferPanel and `cloudflared` up‑to‑date (`apt upgrade`).  

---  

## Contributing  

Contributions are encouraged! Feel free to:

- Open an **issue** for bugs or feature requests.  
- Submit a **pull request** with improvements (e.g., additional tunneling options, support for other distros, Docker deployment).  

Please follow the standard GitHub workflow: fork → create a feature branch → commit → open PR.

---  

## License  

This project is licensed under the **MIT License**. See the bundled [LICENSE](LICENSE) file for details.
