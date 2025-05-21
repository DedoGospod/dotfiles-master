# My dotfiles for system configuration 

Run install script for automatic setup (arch linux)
- cd dotfiles master
- chmod +x install-script.sh
- ./install-script.sh

# For manual setup install stow
Arch:
- sudo pacman -S stow
Debian: 
- sudo apt install stow
Fedora:
- sudo dnf install stow

# Stow instructions 
- cd dotfiles-master
- ls (to list avaliable packages)
- stow (package name)

If any package already has a config then:
- rm -rf (package name) then stow package again
