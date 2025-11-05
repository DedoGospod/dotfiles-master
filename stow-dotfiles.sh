#!/usr/bin/env bash

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
            systemd
            tmux
            home-manager
        )

        # Stows packages (including systemd user services) and shows errors if any fail
        echo "---"
        echo "Stowing user packages (TARGET=\$HOME)..."
        for package in "${stow_packages[@]}"; do        
            rustup
            if [ "$package" == "systemd" ]; then
                if [ -d "$package" ]; then
                    echo "Stowing systemd user package files..."
                    stow --restow --target="$HOME" "$package" || echo "ERROR stowing systemd user files"
                else
                    echo "Warning: Package $package not found in $DOTFILES_DIR"
                fi
                continue
            fi

            if [ -d "$package" ]; then
                echo "Stowing user package $package..."
                stow --restow --target="$HOME" "$package" || echo "ERROR stowing $package"
            else
                echo "Warning: Package $package not found in $DOTFILES_DIR"
            fi
        done
        
        echo "---"
        
        # Stows system wide packages
        echo "Stowing system-wide files (REQUIRES SUDO)..."
        
        SYSTEMD_PACKAGE="systemd"

        if [ -d "$SYSTEMD_PACKAGE" ]; then
            echo "Stowing system-wide systemd package files (REQUIRES SUDO)..."
            sudo stow --restow --target=/ "$SYSTEMD_PACKAGE" || echo "ERROR stowing systemd system files"
        
            # Reload the systemd daemon to recognize the new system unit files
            echo "Reloading systemd daemon to recognize new system unit files..."
            sudo systemctl daemon-reload || echo "ERROR reloading systemd daemon"
        
            echo "Systemd stowed (user and system) and system daemon reloaded."
        else
            echo "Warning: Systemd package not found. Skipping systemd system setup."
        fi
        echo "---"
    else
        echo "Warning: Dotfiles directory $DOTFILES_DIR not found. Skipping stow."
    fi
