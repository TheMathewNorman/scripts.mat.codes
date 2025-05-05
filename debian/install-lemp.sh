#!/bin/bash

set -e

# Update and install prerequisites
sudo apt update && sudo apt install -y software-properties-common curl lsb-release ca-certificates apt-transport-https gnupg

# Install NGINX
echo "Installing NGINX..."
sudo apt install -y nginx
sudo systemctl enable nginx
sudo systemctl start nginx

# Install MariaDB
echo "Installing MariaDB..."
sudo apt install -y mariadb-server mariadb-client
sudo systemctl enable mariadb
sudo systemctl start mariadb

# Add PHP 8.3 repository
echo "Adding PHP 8.3 repository..."
sudo add-apt-repository -y ppa:ondrej/php
sudo apt update

# Install PHP 8.3 and modules
echo "Installing PHP 8.3..."
sudo apt install -y php8.3 php8.3-fpm php8.3-mysql php8.3-cli php8.3-curl php8.3-mbstring php8.3-xml php8.3-zip php8.3-bcmath

# Enable and start PHP-FPM
sudo systemctl enable php8.3-fpm
sudo systemctl start php8.3-fpm

# Install NVM
echo "Installing NVM..."
export NVM_VERSION="v0.39.7"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh | bash

# Load NVM (so it's available right after install in this script)
export NVM_DIR="$HOME/.nvm"
# shellcheck disable=SC1091
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

echo -e "\n✅ LEMP Stack (NGINX, MariaDB, PHP 8.3) and NVM ${NVM_VERSION} installed."

echo -e "\nℹ️ Run 'source ~/.bashrc' or restart your shell to start using NVM."