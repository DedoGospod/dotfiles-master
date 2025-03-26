#!/bin/bash

# Update the system and install pacman packages
echo "Updating system..."
sudo pacman -Syu --noconfirm || exit 1

# List of pacman packages
pacman_packages=(
  hyprland
  kitty
  hypridle
  hyprlock
  hyprpaper
  neovim
  starship
  waybar
  wofi
  yazi
  zsh
  nautilus
  swaync
  sway-audio-idle-inhibit
  xdg-desktop-portal-gtk
  xdg-desktop-portal-hyprland
  hyprpolkitagent
  wlsunset
  zoxide
  zsh-syntax-highlighting
  fzf
  qt6ct
  adwaita-dark
  btop
  dbus
)

echo "Installing pacman packages..."
sudo pacman -S --noconfirm "${pacman_packages[@]}" || exit 1

# List of AUR packages
aur_packages=(
  trash-cli
)

echo "Installing AUR packages..."
paru -S --noconfirm "${aur_packages[@]}" || exit 1

# Set zsh as the default shell
echo "Setting zsh as the default shell..."
chsh -s $(which zsh) || exit 1

echo "Installation and setup complete!"
