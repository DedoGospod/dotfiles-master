#!/usr/bin/env bash

# This command fetches and adds the Home Manager signing key
nix-shell -p nix-prefetch-url --run "nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager"

# Add nix home manager channel
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager

# Update the channels to fetch the packages
nix-channel --update

# Install home manager
nix-shell '<home-manager>' -A install
