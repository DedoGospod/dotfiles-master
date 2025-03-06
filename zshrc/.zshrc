# Initialize Starship prompt for Zsh (a fast and customizable shell prompt)
eval "$(starship init zsh)"

# Initialize zoxide for Fish (fast directory navigation)
eval "$(zoxide init zsh)"

# Enable syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Set the default text editor to Neovim
export EDITOR="nvim"
# Use the same editor for sudo commands
export SUDO_EDITOR="$EDITOR"

export XDG_CURRENT_DESKTOP=Hyprland
export XDG_SESSION_TYPE=wayland
export MANPAGER='nvim +Man!'            # Opens man pages in neovim

# Configure shell history settings
HISTFILE=~/.history       # File where command history is stored
HISTSIZE=10000            # Maximum number of commands stored in memory
SAVEHIST=5000             # Maximum number of commands saved to the history file

# Append commands to the history file as they are executed (instead of on shell exit)
setopt inc_append_history

# Initialize Zsh completions
autoload -Uz compinit && compinit

# Load fzf (a fuzzy finder) configuration if it exists
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Allows sudo to be used with alias'
alias sudo='sudo '

# Package management
alias yay='paru'           # Use paru as a drop-in replacement for yay
alias pacman='sudo pacman' # Always use sudo with pacman

# File operations
alias cp='cp -i'           # Confirm before overwriting
alias mv='mv -i'           # Confirm before overwriting
alias mkdir='mkdir -p'     # Create parent directories as needed
alias rm='trash -v'        # Recoverable trash can

# Listing files
alias lsh='ls -A'          # List all files except . and ..

# Terminal utilities
alias cls='clear'          # Clear the terminal screen
alias top='sudo btop'      # Use btop instead of top

# SSH and remote access
alias kssh='kitty +kitten ssh' # Use kitty's SSH kitten

# Quick access to applications
alias y='yazi'             # Quick access to yazi
alias nv='nvim'            # Quick access to nvim

# System commands
alias rb='reboot'          # Reboot the system

# Cleanup
alias cleanflatpak='flatpak uninstall --unused && flatpak repair'

# Debugging/Reverse engineering
alias pince='z appimages && sudo -E ./PINCE-x86_64.AppImage'

# Alias for config files
alias zshrc='nvim /home/dylan/.zshrc'            # Edit zsh config
alias hypr='nvim ~/.config/hypr/hyprland.conf'   # Edit Hyprland config
alias grub='sudo nvim /etc/default/grub'         # Edit GRUB config

# Auto-start Hyprland on tty1 login
if [ "$(tty)" = "/dev/tty1" ]; then
    exec Hyprland
fi

