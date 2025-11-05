#!/usr/bin/env bash


# Add nix home manager channel
nix-channel --add https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz home-manager

# Update the channels to fetch the packages
nix-channel --update

# Install home manager
nix-shell '<home-manager>' -A install
