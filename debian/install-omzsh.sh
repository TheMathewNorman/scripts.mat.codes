#!/bin/bash

# ==============================================================================
# File: install-omzsh.sh
# Description: Installs Zsh and Oh My Zsh for all users on a Debian-based system.
#              This script performs the following:
#              - Installs zsh, curl, and git packages
#              - Installs Oh My Zsh
#              - Sets zsh as default shell for all real users (UID >= 1000)
#              - Installs Oh My Zsh configuration for each user
# Author: Mathew Norman
# Created: 2025-04-26
# Last Updated: 2025-04-26
# ==============================================================================

# Exit on error
set -e

echo "Installing zsh..."
sudo apt update
sudo apt install -y zsh curl git

echo "Installing oh-my-zsh..."
export RUNZSH=no
export CHSH=no
export KEEP_ZSHRC=yes
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Setting zsh as the default shell for all users..."

# Get zsh path
ZSH_PATH=$(which zsh)

# Change shell for current user
echo "Changing shell for current user: $USER"
sudo usermod --shell "$ZSH_PATH" "$USER"

# Install oh-my-zsh for current user if not installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "
        export RUNZSH=no;
        export CHSH=no;
        export KEEP_ZSHRC=yes;
        sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\"
    "
fi

echo "Done! zsh is now the default shell for all real users."