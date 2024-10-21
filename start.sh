#!/bin/bash

# PufferPanel-Serveo-Script (Ubuntu)

# Prerequisites:
# - apt-get installed
# - serveo installed and configured

# Function to install and configure PufferPanel
install_pufferpanel() {
  echo "Installing PufferPanel..."
  sudo apt update
  sudo apt install curl unzip openjdk-11-jre-headless systemctl openssh-client
  curl -s https://packagecloud.io/install/repositories/pufferpanel/pufferpanel/script.deb.sh | sudo bash
  sudo apt update
  sudo apt install pufferpanel
  
  echo "Enter your desired admin username:"
  read ADMIN_USERNAME
  echo "Enter your desired admin password:"
  read -s ADMIN_PASSWORD

  sudo pufferpanel user add --email admin@in3pire.com --name "$ADMIN_USERNAME" --password "$ADMIN_PASSWORD" --admin
  sudo systemctl enable pufferpanel
  sudo systemctl start pufferpanel
}

# Function to set up Serveo tunnel
setup_serveo() {
  echo "Setting up Serveo tunnel..."
  ssh -R 80:localhost:8080 serveo.net -y
  echo "Done!"
}

# Main Script
echo "What do you want to install? (minecraft/nodejs/python)"
read -p "Enter your choice: " choice

if [ "$choice" = "minecraft" ]; then
  install_pufferpanel
  setup_serveo
elif [ "$choice" = "nodejs" ]; then
  install_pufferpanel
  setup_serveo
elif [ "$choice" = "python" ]; then
  install_pufferpanel
  setup_serveo
else
  echo "Invalid choice. Please enter 'minecraft', 'nodejs', or 'python'."
fi

echo "PufferPanel installation and tunneling complete!"
