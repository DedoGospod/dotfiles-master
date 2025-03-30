# ======================
# Shell Initialization
# ======================

# Initialize Starship prompt (fast and customizable shell prompt)
eval "$(starship init zsh)"

# Initialize zoxide (fast directory navigation)
eval "$(zoxide init zsh)"

# Enable Zsh syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Initialize Zsh completions
autoload -Uz compinit && compinit

# Enable zsh autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Load fzf (fuzzy finder) configuration if it exists
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# ======================
# Environment Variables
# ======================

# Set default text editor to Neovim
export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"  # Use Neovim for sudo commands

# Configure XDG environment for Hyprland
export XDG_CURRENT_DESKTOP=Hyprland
export XDG_SESSION_TYPE=wayland

# Use Neovim as the man page viewer
export MANPAGER='nvim +Man!'

# Dark mode for applications
export QT_QPA_PLATFORMTHEME=qt6ct
gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"

# Remove "Recent" section from Nautilus.
gsettings set org.gnome.desktop.privacy remember-recent-files false


# ======================
# Shell History Settings
# ======================

HISTFILE=~/.history  # File where command history is stored
HISTSIZE=10000       # Maximum number of commands stored in memory
SAVEHIST=5000        # Maximum number of commands saved to the history file

# Append commands to history as they are executed (instead of on shell exit)
setopt inc_append_history


# ======================
# Aliases
# ======================

# Package Management
alias yay='paru'            # Use paru as a drop-in replacement for yay
alias pacman='sudo pacman'  # Always use sudo with pacman
alias updatemirrors='sudo reflector --verbose --country Australia --protocol https --sort rate --save /etc/pacman.d/mirrorlist'

# File Operations
alias cp='cp -i'            # Confirm before overwriting
alias mv='mv -i'            # Confirm before overwriting
alias mkdir='mkdir -p'      # Create parent directories as needed
alias rm='trash -v'         # Recoverable trash can
alias lsh='ls -A'           # List all files except . and ..
alias ls='ls --color=auto'  # Colorize ls output

# Terminal Utilities
alias cls='clear'           # Clear the terminal screen
alias top='btop'            # Use Btop as a drop in replacement for top

# SSH and Remote Access
alias kssh='kitty +kitten ssh'  # Use kitty's SSH kitten

# Quick Access to Applications
alias y='yazi'              # Quick access to yazi
alias nv='nvim'             # Quick access to nvim

# System Commands
alias rb='reboot'           # Reboot the system
alias cleanflatpak='flatpak uninstall --unused && flatpak repair'

# Debugging/Reverse Engineering
alias pince='z appimages && sudo -E ./PINCE-x86_64.AppImage'

# Config File Shortcuts
alias zshrc='nvim ~/.zshrc'            # Edit Zsh config
alias hypr='nvim ~/.config/hypr/hyprland.conf'  # Edit Hyprland config
alias grub='sudo nvim /etc/default/grub'  # Edit GRUB config

# Allow sudo to be used with aliases
alias sudo='sudo '


# ======================
# Auto-Start Hyprland
# ======================

# Auto-start Hyprland on tty1 login
if [ "$(tty)" = "/dev/tty1" ]; then
    exec Hyprland
fi
