#!/bin/bash

# --- Configuration ---
PACKAGES_TO_INSTALL="
brave
"

# SHELL_CONFIG="$HOME/.zshrc"
# ---------------------

# --- Multiuser Nix Installation ---
echo "Checking for and installing Nix (Multiuser Mode)..."

# Check if the Nix store exists, which is a good indicator of an installation
if [ ! -d "/nix/store" ]; then
    echo "🚨 Nix not found. Starting multiuser installation."

    # Download the official Nix installation script
    if ! curl -L https://nixos.org/nix/install > /tmp/install-nix-script.sh; then
        echo "❌ ERROR: Failed to download Nix installation script." >&2
        exit 1
    fi

    if ! sh /tmp/install-nix-script.sh --daemon; then
        echo "❌ ERROR: Multiuser Nix installation failed." >&2
        rm -f /tmp/install-nix-script.sh
        exit 1
    fi

    rm -f /tmp/install-nix-script.sh
    echo "✅ Multiuser Nix installed successfully. Rebooting/re-logging may be needed for full system-wide setup."
else
    echo "✅ Nix store found at /nix/store. Skipping installation."
fi


export XDG_DATA_DIRS=$HOME/.nix-profile/share:$XDG_DATA_DIRS


## Package Installation

echo "Installing packages: $PACKAGES_TO_INSTALL"

# We check if 'nix-env' is available before trying to run it
if ! command -v nix-env &> /dev/null; then
    echo "ERROR: 'nix-env' command not found. Multiuser installation or profile sourcing may have failed." >&2
    exit 1
fi

if ! nix-env -iA nixpkgs."$NIX_PACKAGE_ARGS"; then
    echo "ERROR: Nix package installation failed. Check package names or Nix setup." >&2
    exit 1
fi

echo "✅ Packages installed successfully."
echo "---"

## Final Instructions

echo "Setup complete!"
echo "To use your new packages, please **open a new terminal** or run: "
echo "source $SHELL_CONFIG"
