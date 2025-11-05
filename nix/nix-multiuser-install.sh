#!/usr/bin/env bash

sudo pacman -S curl
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon

# 5. Restart the Nix Daemon
echo "Restarting the nix-daemon to apply new configuration..."
sudo systemctl daemon-reload
sudo systemctl restart nix-daemon
echo "✅ Nix daemon restarted."

# Finalizing the script with a reboot prompt
echo ""
echo "------------------------------------------------------"
echo "Installation and configuration tasks are complete! 🎉"
echo "IMPORTANT!! Log out and log back in for changes to take effect"
echo "------------------------------------------------------"
