#!/usr/bin/env bash

# PufferPanel-Serveo-Script (updated)
# Updated for PufferPanel 3.x and Cloudflare Tunnel (cloudflared)
# Requires root privileges

set -euo pipefail

# Check for root
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root (or with sudo)."
  exit 1
fi

# Function to install dependencies
install_dependencies() {
  echo "Installing required packages..."
  apt-get update -y
  apt-get install -y curl unzip openjdk-17-jre-headless systemd ssh

  # Install cloudflared (Cloudflare Tunnel)
  if ! command -v cloudflared >/dev/null 2>&1; then
    echo "Installing cloudflared..."
    curl -fsSL https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb -o /tmp/cloudflared.deb
    apt-get install -y /tmp/cloudflared.deb
    rm -f /tmp/cloudflared.deb
  fi
}

# Function to install and configure PufferPanel (latest version)
install_pufferpanel() {
  echo "Installing PufferPanel..."
  # Add the official repository (packagecloud script)
  curl -fsSL https://packagecloud.io/install/repositories/pufferpanel/pufferpanel/script.deb.sh | sudo bash
  apt-get update -y
  apt-get install -y pufferpanel

  # Prompt for admin credentials
  read -rp "Enter admin username: " ADMIN_USERNAME
  read -rsp "Enter admin password: " ADMIN_PASSWORD
  echo

  # Create admin user (email is placeholder)
  sudo pufferpanel user add --email admin@in3pire.com --name "${ADMIN_USERNAME}" --password "${ADMIN_PASSWORD}" --admin

  systemctl enable pufferpanel
  systemctl start pufferpanel
}

# Function to create Cloudflare Tunnel to expose PufferPanel (default port 8080)
setup_cloudflare_tunnel() {
  echo "Setting up Cloudflare Tunnel..."
  # Create a tunnel (named pufferpanel) and route to local port 8080
  # The command will prompt for Cloudflare login if not already authenticated.
  cloudflared tunnel create pufferpanel || true
  # Write config for the tunnel
  TUNNEL_UUID=$(cloudflared tunnel list | awk '/pufferpanel/ {print $1}')
  mkdir -p /etc/cloudflared
  cat > /etc/cloudflared/config.yml <<EOF
url: http://localhost:8080
# Use the tunnel UUID created above
 tunnel: ${TUNNEL_UUID}
EOF
  # Run the tunnel as a systemd service
  cloudflared service install
  systemctl enable cloudflared
  systemctl start cloudflared
  echo "Tunnel established. Access your PufferPanel via the generated *.trycloudflare.com URL."
}

# Main menu
echo "Select what to install (minecraft/nodejs/python). This only determines which PufferPanel template will be used later."
read -rp "Enter your choice: " choice
case "$choice" in
  minecraft|nodejs|python)
    install_dependencies
    install_pufferpanel
    setup_cloudflare_tunnel
    ;;
  *)
    echo "Invalid choice. Exiting."
    exit 1
    ;;
esac

echo "PufferPanel installation and Cloudflare Tunnel setup complete!"
