#!/bin/bash
set -euo pipefail

# --- Configuration ---
NIX_CONF_PATH="/etc/nix/nix.conf"
NIX_INSTALL_URL="https://nixos.org/nix/install"
NIX_HM_DIR="$HOME/.config/nix-home-manager-init"
USER_NAME=$(whoami)

echo "🚀 Starting Nix Multi-User Flake & Home Manager Installation..."

# 1. Check for required permissions
if [ "$(id -u)" -eq 0 ]; then
    echo "⚠️ This script should be run as a standard user, not root (sudo will be used when needed)."
    exit 1
fi

# 2. Check for dependencies (curl is needed for the install script)
if ! command -v curl &> /dev/null; then
    echo "🚨 Error: 'curl' is not installed. Please install it first (e.g., 'sudo apt install curl' or 'sudo pacman -S curl')."
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
sudo tee "$NIX_CONF_PATH" > /dev/null << EOF
# Configuration added by the Nix install script
experimental-features = nix-command flakes
substituters = https://cache.nixos.org/ https://hydra.iohk.io/
trusted-public-keys = cache.nixos.org-1:6NCHDkmO4erP21FV32m5XxnthPNsuxFNlqfQzVjm9s8= hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+aBLG+o/NnVG/EzhguyZdXw=
EOF
echo "✅ $NIX_CONF_PATH updated to enable flakes and set binary caches."

# 5. Restart the Nix Daemon
echo "Restarting the nix-daemon to apply new configuration..."
sudo systemctl daemon-reload
sudo systemctl restart nix-daemon
echo "✅ Nix daemon restarted."

# --- HOME MANAGER SETUP (New Steps) ---

# 6. Source Nix Environment for current script execution
echo "Sourcing Nix profile to make 'nix' command available immediately for this script..."
NIX_PROFILE_SCRIPT="/etc/profile/nix.sh"
if [ -f "$NIX_PROFILE_SCRIPT" ]; then
    # We source the profile script to set up environment variables for the current shell
    . "$NIX_PROFILE_SCRIPT"
    echo "✅ Nix profile sourced."
else
    echo "⚠️ Could not find multi-user Nix profile script at $NIX_PROFILE_SCRIPT. Home Manager installation might fail if 'nix' command is not in PATH."
fi

# 7. Create Home Manager Flake Configuration
mkdir -p "$NIX_HM_DIR"
echo "Creating initial home-manager flake configuration in $NIX_HM_DIR..."

# Create flake.nix
tee "$NIX_HM_DIR/flake.nix" > /dev/null << EOF
{
  description = "Initial Home Manager configuration for ${USER_NAME}";

  inputs = {
    # Use a specific nixpkgs branch for stability (e.g., nixos-unstable)
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
    # Ensure home-manager uses the same nixpkgs as the main system
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    # Define a configuration for the current user
    homeConfigurations."${USER_NAME}" = home-manager.lib.home.buildHomeConfiguration {
      inherit nixpkgs;
      modules = [
        ./home.nix
      ];
    };
  };
}
EOF

# Create home.nix (The actual configuration)
tee "$NIX_HM_DIR/home.nix" > /dev/null << EOF
{ config, pkgs, ... }:

{
  # Set up a minimal configuration
  home.username = "${USER_NAME}";
  home.homeDirectory = "/home/${USER_NAME}";
  # The stateVersion determines what generation of HM you are using.
  # Use a recent stable version or the one recommended by the HM documentation.
  home.stateVersion = "24.05"; 

  # Example package: just 'nix-info' and 'hello' to confirm it works
  home.packages = [
    pkgs.hello
    pkgs.nix-info
  ];

  # Allow Home Manager to manage your shell configuration (CRITICAL STEP)
  programs.home-manager.enable = true;
}
EOF

# 8. Install/Switch Home Manager
echo "Installing Home Manager for user '$USER_NAME' using the new flake configuration..."
# The 'nix run' command temporarily fetches and runs the home-manager tool from the flake.
if nix run home-manager/master -- switch --flake "${NIX_HM_DIR}#${USER_NAME}"; then
    echo "✅ Home Manager installation and initial switch successful."
    echo "Your Home Manager configuration is located at $NIX_HM_DIR."
    echo "NOTE: The 'home-manager' command is now installed into your user profile, but it is not yet available in this terminal session."
else
    echo "❌ Home Manager installation failed. Check the errors above."
    # We do not exit 1 here, as Nix itself is installed, and the user can debug HM later.
fi

# --- Final Instructions ---
echo -e "\n------------------------------------------------------------"
echo "🎉 Installation Complete! (Nix Multi-User & Home Manager)"
echo "------------------------------------------------------------"
echo "🚨 CRITICAL: The 'home-manager' command will not be found until you restart your shell."
echo "To finalize and use your new environment immediately, you MUST:"
echo "1. **RESTART YOUR CURRENT SHELL** (or open a new terminal). This reloads your shell configuration (e.g., .bashrc, .zshrc) which now points to the 'home-manager' executable."
echo "2. After restarting, verify the installation by running:"
echo "   hello"
echo "   nix-info -m"
echo "You can now edit your Home Manager configuration in $NIX_HM_DIR and run 'home-manager switch --flake $NIX_HM_DIR#$USER_NAME' to apply changes."
echo "------------------------------------------------------------"
