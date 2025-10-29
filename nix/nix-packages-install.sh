#!/usr/bin/env bash

# This script installs a set of packages for the current user using the Nix multi-user profile.

# Define the packages you want to install
PACKAGES=(
    nixpkgs#brave        # Brave Browser
    # nixpkgs#btop       # Interactive process viewer
)

echo "Installing the following packages for the current user:"
for pkg in "${PACKAGES[@]}"; do
    echo "- ${pkg/nixpkgs#/}" # Prints the package name without the prefix
done
echo ""

# Use nix profile install to install all packages at once
nix profile install --accept-flake-config "${PACKAGES[@]}"

if [ $? -eq 0 ]; then 
    echo "All selected packages have been successfully installed."
    echo "You might need to start a new shell session (e.g., re-login, or run 'exec \$SHELL') for the new commands to be immediately available."
else
    echo "Error: One or more package installations failed."
    exit 1
fi


# Add nix pkgs to environemnt
export XDG_DATA_DIRS=$HOME/.nix-profile/share:$XDG_DATA_DIRS
