#!/bin/bash
set -euo pipefail

# --- Configuration ---
NIX_CONF_PATH="/etc/nix/nix.conf"
NIX_INSTALL_URL="https://nixos.org/nix/install"

echo "🚀 Starting Nix Multi-User Flake Installation..."

# 1. Check for required permissions
if [ "$(id -u)" -eq 0 ]; then
  echo "⚠️ This script should be run as a standard user, not root (sudo will be used when needed)."
  exit 1
fi

# 2. Check for dependencies (curl is needed for the install script)
if ! command -v curl &> /dev/null; then
    echo "🚨 Error: 'curl' is not installed. Please install it first (e.g., 'sudo pacman -S curl')."
    exit 1
fi

# 3. Perform the Multi-User Installation
echo "Installing Nix in multi-user mode with the daemon..."
if curl -L "$NIX_INSTALL_URL" | sh -s -- --daemon; then
    echo "✅ Nix Multi-User installation script executed successfully."
else
    echo "❌ Nix installation failed. Exiting."
    exit 1
fi

# 4. Enable Flakes and Nix Command
echo "Enabling flakes and the new nix-command in $NIX_CONF_PATH..."

# Ensure the directory exists
sudo mkdir -p /etc/nix

# Add/Update the experimental features line and substituters
# We use sudo tee to write to the root-owned file
sudo tee "$NIX_CONF_PATH" > /dev/null << EOF
# Configuration added by the Nix install script
experimental-features = nix-command flakes
substituters = https://cache.nixos.org/ https://hydra.iohk.io/
trusted-public-keys = cache.nixos.org-1:6NCHDkmO4erP21FV32m5XxnthPNsuxFNlqfQzVjm9s8= hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+aBLG+o/NnVG/EzhguyZdXw=
EOF
echo "✅ $NIX_CONF_PATH updated to enable flakes and set binary caches."

# 5. Add current user to the 'nix-users' group
echo "Adding user '$USER' to the 'nix-users' group."
if ! grep -q "$USER" /etc/group | grep -q "nix-users"; then
    sudo usermod -aG nix-users "$USER"
fi
echo "✅ User added to nix-users group (requires re-login to fully take effect)."

# 6. Restart the Nix Daemon
echo "Restarting the nix-daemon to apply new configuration..."
sudo systemctl daemon-reload
sudo systemctl restart nix-daemon
echo "✅ Nix daemon restarted."

# --- Final Instructions ---
echo -e "\n------------------------------------------------------------"
echo "🎉 Nix Installation Complete!"
echo "------------------------------------------------------------"
echo "To finalize the installation and use the 'nix' command immediately, you MUST:"
echo "1. **Source the Nix profile:**"
echo "   . /etc/profile/nix.sh"
echo "2. **Restart your current shell** (or open a new terminal)."
echo -e "\nAfter restarting your shell, verify the installation by running:"
echo "nix shell nixpkgs#hello --command hello"
echo "------------------------------------------------------------"
