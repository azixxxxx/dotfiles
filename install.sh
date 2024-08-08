#!/bin/bash

# Exit on error
set -e

# Update and upgrade the system
echo "Updating and upgrading the system..."
sudo pacman -Syu --noconfirm

# Install essential packages
echo "Installing essential packages..."
sudo pacman -S --noconfirm base-devel git wget stow fish alacritty fastfetch mangohud gamemode variety timeshift goverlay qbittorrent discord

# Install AMD drivers
echo "Installing AMD drivers..."
sudo pacman -S --noconfirm xf86-video-amdgpu mesa vulkan-radeon

# Install Heroic Games Launcher
echo "Installing Heroic Games Launcher..."
# Install yay AUR helper if not already installed
if ! command -v yay &> /dev/null; then
    echo "Installing yay..."
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
fi

# Install Heroic Games Launcher using yay
yay -S --noconfirm heroic-games-launcher

# Install LACT
echo "Installing LACT..."
yay -S --noconfirm lact

# Clone dotfiles repository if not already present
DOTFILES_DIR="$HOME/dotfiles"
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "Cloning dotfiles repository..."
    git clone https://github.com/azixxxxx/dotfiles.git "$DOTFILES_DIR"
fi

# Change to dotfiles directory
cd "$DOTFILES_DIR"

# Install dotfiles using stow
echo "Stowing dotfiles..."
stow fish alacritty fastfetch

# Set fish as the default shell (optional)
echo "Setting fish as the default shell..."
chsh -s /usr/bin/fish

# Clean up package cache to save space
echo "Cleaning up package cache..."
sudo pacman -Scc --noconfirm

# Display a success message
echo "Installation complete!"
