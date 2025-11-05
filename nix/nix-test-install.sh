#!/usr/bin/env bash

sudo pacman -S nix

sudo systemctl enable nix-daemon
sudo systemctl start nix-daemon

sudo gpasswd -a "$USER" nix-users

echo "Log out and log back in for changes to take effect"
