#!/usr/bin/env bash

sudo pacman -S curl
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon

# 5. Restart the Nix Daemon
echo "Restarting the nix-daemon to apply new configuration..."
sudo systemctl daemon-reload
sudo systemctl restart nix-daemon
echo "✅ Nix daemon restarted."

# Define the user-specific Nix configuration file path
NIX_CONF_DIR="$HOME/.config/nix"
NIX_CONF_FILE="$NIX_CONF_DIR/nix.conf"
FLAKES_SETTING="experimental-features = nix-command flakes"

echo "Attempting to enable Nix Flakes for the current user..."

# 1. Create the configuration directory if it doesn't exist
if [ ! -d "$NIX_CONF_DIR" ]; then
    echo "Creating directory: $NIX_CONF_DIR"
    mkdir -p "$NIX_CONF_DIR"
fi

# 2. Check if the Flakes setting is already present
if grep -qF "$FLAKES_SETTING" "$NIX_CONF_FILE"; then
    echo "Nix Flakes setting is already present in $NIX_CONF_FILE."
else
    # 3. Add the Flakes setting to the configuration file
    echo "Adding '$FLAKES_SETTING' to $NIX_CONF_FILE"
    # The '>>' appends the line to the file, creating it if it doesn't exist
    echo "$FLAKES_SETTING" >> "$NIX_CONF_FILE"
    echo "Successfully enabled Nix Flakes."
fi

# 4. Verification step (optional but helpful)
echo
echo "--- Verification ---"
echo "Running: nix flake show nixpkgs"
# Use the --extra-experimental-features flag here just in case the new config
# hasn't been picked up by the shell environment yet, providing a robust check.
nix --extra-experimental-features "nix-command flakes" flake show nixpkgs
