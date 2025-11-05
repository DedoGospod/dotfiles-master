#!/usr/bin/env bash

sudo pacman -S curl
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon

# 5. Restart the Nix Daemon
echo "Restarting the nix-daemon to apply new configuration..."
sudo systemctl daemon-reload
sudo systemctl restart nix-daemon
echo "✅ Nix daemon restarted."

echo "Log out and log back in for changes to take effect"
echo "vim into /etc/nix/nix.conf and on a new line add: experimental-features = nix-command flakes"
