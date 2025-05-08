# ======================
# XDG Base Directory Enforcement 
# ======================

# Set XDG paths according to the XDG Base Directory Specification
export XDG_DATA_HOME="$HOME/.local/share"    # User-specific data files
export XDG_CONFIG_HOME="$HOME/.config"       # User-specific configuration files
export XDG_STATE_HOME="$HOME/.local/state"   # User-specific state files (logs, history)
export XDG_CACHE_HOME="$HOME/.cache"         # User-specific non-essential cached files

# Create these directories if they don't exist (-p flag prevents errors if directories already exist)
mkdir -p "$XDG_DATA_HOME" "$XDG_CONFIG_HOME" "$XDG_STATE_HOME" "$XDG_CACHE_HOME"

# ======================
# ZSH Configuration
# ======================

# History settings configured to be XDG-compliant
export HISTFILE="${XDG_STATE_HOME}/zsh/history"  # Store history in XDG state directory
HISTSIZE=10000                                   # Number of commands kept in memory
SAVEHIST=5000                             # Number of commands saved to HISTFILE
setopt inc_append_history                        # Save commands to history immediately

# Completion cache location (XDG-compliant)
export ZSH_COMPDUMP="${XDG_CACHE_HOME}/zsh/zcompdump-${ZSH_VERSION}"  # Cache file for completions

# ======================
# Shell Initialization
# ======================

# Initialize ZSH completions system
autoload -Uz compinit
compinit -d "${ZSH_COMPDUMP}"  # Explicitly use our custom XDG-compliant path

# Load plugins with existence checks to prevent errors
plugin_dir="/usr/share/zsh/plugins"
[ -f "$plugin_dir/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && \
    source "$plugin_dir/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
[ -f "$plugin_dir/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && \
    source "$plugin_dir/zsh-autosuggestions/zsh-autosuggestions.zsh"

# Initialize tools
eval "$(starship init zsh)"  # Custom shell prompt 
eval "$(zoxide init zsh)"    # Initialize zoxide

# FZF key bindings and completion
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh

# ======================
# Environment Variables
# ======================

# Editor preferences
export EDITOR="nvim"                  # Set Neovim as default editor
export SUDO_EDITOR="$EDITOR"          # Editor for sudo operations
export MANPAGER='nvim +Man!'          # Use Neovim for man pages

# PATH modifications
export PATH="$HOME/.local/bin:$PATH"  # Add user-local binaries to PATH

# Application-specific XDG paths
export CARGO_HOME="$XDG_DATA_HOME/cargo"               # Rust package manager
export GNUPGHOME="$XDG_DATA_HOME/gnupg"                # GnuPG (encryption)
export PYTHONHISTORY="$XDG_STATE_HOME/python/history"  # Python command history

# ========
# Aliases 
# ========

# System
alias sudo='sudo '  
alias rb='reboot'
alias updatemirrors='sudo reflector --verbose --country Australia --protocol https --sort rate --save /etc/pacman.d/mirrorlist'
alias cleanflatpak='flatpak uninstall --unused && flatpak repair'
alias update-grub="grub-mkconfig -o /boot/grub/grub.cfg"

# Package Management
alias yay='paru'             # Use paru as yay alternative
alias pacman='sudo pacman'   # Always use sudo with pacman

# Files
alias cp='cp -i'            # Interactive copy
alias mv='mv -i'            # Interactive move
alias rm='trash -v'         # Safe delete using trash-cli
alias mkdir='mkdir -p'      # Create parent directories automatically
alias ls='ls --color=auto'  # Colorized ls output
alias lsh='ls -A'           # Show all files including hidden
alias h='history | grep'    # Search history for a specific terminal command

# Apps
alias nv='nvim'             # Neovim shortcut
alias y='yazi'              			       # Terminal file manager
alias top='btop'           			       # Modern system monitor
alias cls='clear'          			       # Clear screen
alias kssh='kitty +kitten ssh'                         # SSH with kitty terminal features
alias songrec='flatpak run com.github.marinm.songrec'  # Song recognition app

# Configs
alias zshrc='nvim ~/.zshrc'                     # Edit zsh config
alias hypr='nvim ~/.config/hypr/hyprland.conf'  # Edit Hyprland config
alias grub='sudo nvim /etc/default/grub'        # Edit GRUB config

# ======================
# Auto-Start Hyprland
# ======================

# Automatically start Hyprland when logging in on tty1
# Only if not running in a virtual machine (detected by systemd-detect-virt)
if [ "$(tty)" = "/dev/tty1" ] && ! systemd-detect-virt -q; then
    exec Hyprland  # Replace shell with Hyprland
fi

# Auto-start Gamescope on TTY6
if [[ $(tty) == "/dev/tty6" ]]; then
    ~/.local/bin/launch-gamescope.sh
fi
