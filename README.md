# PufferPanel-Serveo-Script (Ubuntu)

**Owner:** IN3PIRE

This script automates the process of installing PufferPanel, configuring it with admin credentials, and then setting up a Serveo tunnel for easy public access.

## Overview

This script streamlines the entire process of getting a PufferPanel server up and running, making it accessible from anywhere in the world:

1. **Installs PufferPanel:**  Downloads and installs the latest PufferPanel server.
2. **Asks for Admin Credentials:** Prompts you to enter your desired admin username and password.
3. **Configures PufferPanel:**  Sets up PufferPanel with the provided credentials.
4. **Creates a Serveo Tunnel:**  Generates a secure and accessible Serveo URL for your server.

## Prerequisites

* **apt-get:** You need to have `apt-get` installed on your Ubuntu server.
* **Serveo:** You need to have Serveo installed and configured. [https://serveo.net/](https://serveo.net/)

## Installation

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/IN3PIRE/PufferPanel-Serveo-Script.git
   ```

2. **Make the Script Executable:**
   ```bash
   chmod +x start.sh
   ```

## Usage

1. **Run the Script:**
   ```bash
   ./start.sh
   ```

2. **Provide Admin Credentials:**
   - The script will prompt you to enter your desired:
      - **Admin Username**
      - **Admin Password**

3. **Wait for Installation:**
   - The script will:
     - Download PufferPanel
     - Install PufferPanel
     - Configure PufferPanel with your credentials
     - Set up a Serveo tunnel

4. **Access PufferPanel:**
   - The script will output the Serveo URL for your PufferPanel server.
   - Open this URL in your web browser to access your server.

## Features

* **Automated PufferPanel Installation:**  Downloads and sets up the server.
* **Admin Credential Input:**  Lets you choose your username and password.
* **Serveo Tunnel Configuration:**  Creates a secure public address for your server.
* **Easy Access:**  Provides a convenient Serveo URL for remote management.

## Notes

* **Security:** This script automates basic PufferPanel setup. For enhanced security, review and customize your PufferPanel settings after installation.
* **Serveo Usage:**  Be aware of Serveo's usage policies and any limitations they may have.

## Contributing

Contributions are welcome! Feel free to open issues or pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
