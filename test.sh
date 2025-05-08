#!/bin/bash

# Enable error checking for all commands
set -e

# Set XDG paths according to the XDG Base Directory Specification
echo "Setting XDG paths"
export XDG_DATA_HOME="$HOME/.local/share"    # User-specific data files
export XDG_CONFIG_HOME="$HOME/.config"       # User-specific configuration files
export XDG_STATE_HOME="$HOME/.local/state"   # User-specific state files (logs, history)
export XDG_CACHE_HOME="$HOME/.cache"         # User-specific non-essential cached files

# Create the directories if they don't exist
echo "Creating XDG directories"
mkdir -p "$XDG_DATA_HOME" "$XDG_CONFIG_HOME" "$XDG_STATE_HOME" "$XDG_CACHE_HOME"

# Install paru if not already installed
if ! command -v paru &> /dev/null; then
    echo "Installing paru..."
    sudo pacman -S --needed --noconfirm base-devel git
    git clone https://aur.archlinux.org/paru.git /tmp/paru
    (cd /tmp/paru && makepkg -si --noconfirm)
    rm -rf /tmp/paru
fi

# Update the system
echo "Updating system..."
sudo pacman -Syu --noconfirm

# Ask if gaming-related packages should be installed
read -r -p "Do you want to install gaming-related packages? (y/N): " install_gaming

# Ask if NVIDIA drivers should be installed
read -r -p "Do you want to install NVIDIA drivers? (y/N): " install_nvidia

# List of base pacman packages
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
  nautilus
  swaync
  xdg-desktop-portal-gtk
  xdg-desktop-portal-hyprland
  hyprpolkitagent
  hyprland-qtutils
  hyprutils
  wlsunset
  zoxide
  zsh
  zsh-syntax-highlighting
  zsh-autosuggestions
  fzf
  qt6ct
  btop
  dbus
  stow
  flatpak
  ttf-cascadia-code
  ttf-ubuntu-font-family
  ttf-font-awesome
  pavucontrol
  ripgrep
  mpv
  ffmpeg
  ffmpegthumbnailer
  fastfetch
  linux-headers
  linux-zen
  linux-zen-headers
  ncdu
  networkmanager
)

# NVIDIA driver packages
nvidia_packages=(
  libva-nvidia-driver
  nvidia-dkms
  nvidia-utils
  nvidia-settings
  cuda
  egl-wayland
)

# Gaming-related packages
gaming_packages=(
  gamemode
  gamescope
  mangohud
)

# Conditionally add NVIDIA packages
if [[ "$install_nvidia" =~ ^[Yy]$ ]]; then
  pacman_packages+=("${nvidia_packages[@]}")
fi

# Conditionally add gaming packages
if [[ "$install_gaming" =~ ^[Yy]$ ]]; then
  pacman_packages+=("${gaming_packages[@]}")
fi

echo "Installing pacman packages..."
sudo pacman -S --needed --noconfirm "${pacman_packages[@]}"

# AUR packages
aur_packages=(
  trash-cli
  adwaita-dark
  hyprshot
  sway-audio-idle-inhibit-git
  brave-bin
)

echo "Installing AUR packages..."
paru -S --needed --noconfirm "${aur_packages[@]}"

# Flatpak apps
flatpak_apps=(
  it.mijorus.gearlever
  com.github.tchx84.Flatseal
  com.stremio.Stremio
  com.usebottles.bottles
)

echo "Installing Flatpak apps..."
flatpak install -y --noninteractive flathub "${flatpak_apps[@]}"

# Set zsh as the default shell
echo "Setting zsh as the default shell..."
chsh -s "$(which zsh)"

# Stow dotfiles
echo "Setting up dotfiles with GNU Stow..."

# Switch to dotfiles directory (if not already there)
DOTFILES_DIR="$HOME/dotfiles-master"

if [ -d "$DOTFILES_DIR" ]; then
    cd "$DOTFILES_DIR"
    
# List of directories to stow (each representing a package)
    stow_packages=(
        backgrounds
        fastfetch
        hypridle
        hyprland
        hyprlock
        hyprmocha
        hyprpaper
        kitty
        mpv
        nvim
        starship
        swaync
        waybar
        wofi
        yazi
        zshrc
    )

    # Stows packages and shows errors if any fail
    for package in "${stow_packages[@]}"; do
        if [ -d "$package" ]; then
            echo "Stowing $package..."
            stow --restow --target="$HOME" "$package"
        else
            echo "Warning: Package $package not found in $DOTFILES_DIR"
        fi
    done
else
    echo "Warning: Dotfiles directory $DOTFILES_DIR not found. Skipping stow."
fi

# Install complete
echo "Installation complete!"
