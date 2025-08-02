#!/bin/bash

# Enable error checking for all commands
set -e

# Set XDG paths according to the XDG Base Directory Specification
echo "Setting XDG paths"
export XDG_DATA_HOME="$HOME/.local/share"     # User-specific data files
export XDG_CONFIG_HOME="$HOME/.config"        # User-specific configuration files
export XDG_STATE_HOME="$HOME/.local/state"    # User-specific state files (logs, history)
export XDG_CACHE_HOME="$HOME/.cache"          # User-specific non-essential cached files

# Set application specific XDG paths
echo "Setting application specific XDG paths"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"                                      # GnuPG (encryption)
export PYTHONHISTORY="$XDG_STATE_HOME/python/history"                        # Python command history
export HISTFILE="${XDG_STATE_HOME}/zsh/history"                              # Store zsh history
export ZSH_COMPDUMP="${XDG_CACHE_HOME}/zsh/zcompdump-${ZSH_VERSION}"         # Store zsh cache file for completions

# Create the directories if they don't exist
echo "Creating XDG directories"
mkdir -p "$XDG_DATA_HOME" "$XDG_CONFIG_HOME" "$XDG_STATE_HOME" "$XDG_CACHE_HOME"

# Create zsh-specifc XDG directories
echo "Creating zsh-specific XDG directories"
mkdir -p "${XDG_STATE_HOME}/zsh"                                        # Ensure zsh state directory exists
mkdir -p "${XDG_CACHE_HOME}/zsh"                                        # Ensures zsh cache directory exists

# Install rustup if not already installed
if ! command -v rustup &> /dev/null; then
    echo "Installing rustup using pacman..."
    sudo pacman -S --noconfirm rustup  # Install rustup
    if [ $? -eq 0 ]; then
        echo "Rustup installed successfully via pacman."
        # Source the cargo environment
        if [ -f "$HOME/.cargo/env" ]; then # Check default location
            source "$HOME/.cargo/env"
            echo "Rust environment sourced."
        elif [ -f "$XDG_DATA_HOME/cargo/env" ]; then # Check the XDG location.
            source "$XDG_DATA_HOME/cargo/env"
            echo "Rust environment sourced."
        else
            echo "Warning: Cargo environment file not found. You may need to open a new terminal or run 'source $HOME/.cargo/env' manually."
        fi
        # Install the stable toolchain by default
        rustup default stable
        echo "Stable toolchain installed."
    else
        echo "Failed to install rustup using pacman.  Exiting."
        exit 1
    fi
else
    echo "Rustup is already installed."
fi

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

# Ask if Neovim related packages should be installed
read -r -p "Do you want to install Neovim related packages? (y/N): " install_neovim

# Ask if dotfiles should be stowed
read -r -p "Do you want to set up dotfiles with GNU Stow? (y/N): " stow_dotfiles

# List of base pacman packages
pacman_packages=(
    kitty
    uwsm
    hyprland
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
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    hyprpolkitagent
    hyprland-qtutils
    hyprutils
    wlsunset
    qt5-wayland
    qt6-wayland
    zoxide
    zsh
    zsh-completions
    zsh-syntax-highlighting
    zsh-autosuggestions
    fzf
    qt6ct
    btop
    dbus
    stow
    flatpak
    ttf-cascadia-code-nerd
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
    reflector
    timeshift
    cronie
    pipewire
    wireplumber
    bat
    man
    tlp
    tmux
    gnome-disk-utility
)

# NVIDIA driver packages
nvidia_packages=(
    libva-nvidia-driver
    nvidia-dkms
    nvidia-utils
    nvidia-settings
    lib32-nvidia-utils
    egl-wayland
)

# Gaming-related packages
gaming_packages=(
    gamemode
    gamescope
    mangohud
)

# Neovim related packages
neovim_packages=(
    npm
    nodejs
    unzip
    clang
    go
    shellcheck
    zig
    luarocks
    dotnet-sdk
    cmake
    gcc
    imagemagick
)

# Conditionally add NVIDIA packages
if [[ "$install_nvidia" =~ ^[Yy]$ ]]; then
    pacman_packages+=("${nvidia_packages[@]}")
fi

# Conditionally add gaming packages
if [[ "$install_gaming" =~ ^[Yy]$ ]]; then
    pacman_packages+=("${gaming_packages[@]}")
fi

# Conditionally add Neovim packages
if [[ "$install_neovim" =~ ^[Yy]$ ]]; then
    pacman_packages+=("${neovim_packages[@]}")
fi

echo "Installing pacman packages..."
sudo pacman -S --needed --noconfirm "${pacman_packages[@]}"

# AUR packages
aur_packages=(
    trash-cli
    adwaita-dark
    hyprshot
    sway-audio-idle-inhibit-git
)

echo "Installing AUR packages..."
paru -S --needed --noconfirm "${aur_packages[@]}"

# Flatpak apps
flatpak_apps=(
    it.mijorus.gearlever
    com.github.tchx84.Flatseal
    com.stremio.Stremio
    com.usebottles.bottles
    com.brave.Browser
    com.vysp3r.ProtonPlus
    com.vixalien.sticky
)

echo "Installing Flatpak apps..."
flatpak install -y --noninteractive flathub "${flatpak_apps[@]}"

# Set zsh as the default shell
echo "Setting zsh as the default shell..."
chsh -s "$(which zsh)"

# Stow dotfiles conditionally
if [[ "$stow_dotfiles" =~ ^[Yy]$ ]]; then
    echo "Setting up dotfiles with GNU Stow..."

# Switch to dotfiles directory (if not already there)
    DOTFILES_DIR="$HOME/dotfiles-master"

    if [ -d "$DOTFILES_DIR" ]; then
        cd "$DOTFILES_DIR"

        # List of directories to stow
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
            gtk
            systemd
            tmux
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
else
    echo "Skipping dotfiles setup."
fi

# Gamescope setup for smooth performance
if [[ "$install_gaming" =~ ^[Yy]$ ]]; then
    echo "Setting up gamescope for smooth performance..."
    sudo setcap 'cap_sys_nice=+ep' "$(which gamescope)"
fi

# Install tmux pkg manager
echo "Installing tmux pkg manager..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

## SYSTEM SERVICES ##

# Disable systemd-networkd-wait-online service 
echo "Disabling systemd-networkd-wait-online service..."
sudo systemctl disable --now systemd-networkd-wait-online.service

# Enable cronie.service
echo "Enabling cronie service..." 
sudo systemctl enable --now cronie.service

# Enable TLP power saving
echo "Enabling TLP service..."
sudo systemctl enable --now tlp.service

## USER SERVICES ##

# Enable hypridle
echo "Enabling hypridle service..."
systemctl --user enable --now hypridle.service

# Enable polkitagent
echo "Enabling hyprpolkitagent service..."
systemctl --user enable --now hyprpolkitagent.service

# Enable Blue light filter
echo "Enabling wlsunset service..."
systemctl --user enable --now wlsunset.service"

# Installation complete
echo "Installation complete!"
