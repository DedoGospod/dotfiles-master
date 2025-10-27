#!/bin/bash

PACKAGES_TO_INSTALL="
brave
"

# 2. Specify your shell config file.
SHELL_CONFIG="$HOME/.zshrc"
# ---------------------

# --- Environment Setup ---
echo "🔄 Starting Nix environment setup..."

# 1. Add Nix Bin to PATH persistently
PATH_EXPORT_LINE='export PATH="$HOME/.nix-profile/bin:$PATH"'
if ! grep -qF "$PATH_EXPORT_LINE" "$SHELL_CONFIG" 2>/dev/null; then
    echo -e "\n# Nix Package Manager PATH setup" >> "$SHELL_CONFIG"
    echo "$PATH_EXPORT_LINE" >> "$SHELL_CONFIG"
    echo "✅ Persistent PATH added to $SHELL_CONFIG."
else
    echo "✅ PATH variable already set in $SHELL_CONFIG. Skipping."
fi

# 2. Set XDG_DATA_DIRS persistently
EXPORT_LINE_XDG='export XDG_DATA_DIRS=$HOME/.nix-profile/share:$XDG_DATA_DIRS'
if ! grep -qF "$EXPORT_LINE_XDG" "$SHELL_CONFIG" 2>/dev/null; then
    echo -e "\n# Nix XDG_DATA_DIRS setup" >> "$SHELL_CONFIG"
    echo "$EXPORT_LINE_XDG" >> "$SHELL_CONFIG"
    echo "✅ XDG_DATA_DIRS added to $SHELL_CONFIG."
fi

# 3. Set environment for the current script session
export PATH="$HOME/.nix-profile/bin:$PATH"
export XDG_DATA_DIRS="$HOME/.nix-profile/share:$XDG_DATA_DIRS"

echo "---"

# --- Package Installation  ---
echo "📦 Installing packages: $PACKAGES_TO_INSTALL"

# Correctly format the package list based on count
if [[ "$PACKAGES_TO_INSTALL" == *[[:space:]]* ]]; then
    # Multiple packages: use the {pkg1,nixpkgs.pkg2} format
    NIX_PACKAGE_ARGS="{$(echo $PACKAGES_TO_INSTALL | sed 's/ /,nixpkgs./g')}"
else
    # Single package: use the simple pkg1 format
    NIX_PACKAGE_ARGS="$PACKAGES_TO_INSTALL"
fi

# Execute the installation command
echo "Running: nix-env -iA nixpkgs.$NIX_PACKAGE_ARGS"
if ! nix-env -iA nixpkgs."$NIX_PACKAGE_ARGS"; then
    echo "❌ ERROR: Nix package installation failed. Check package names." >&2
    exit 1
fi

echo "✅ Packages installed successfully."
echo "---"
echo "🎉 Setup complete!"
echo "To use your new packages, please **open a new terminal** or run: "
echo "source $SHELL_CONFIG"
