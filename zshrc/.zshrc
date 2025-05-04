# ======================
# XDG Base Directory Enforcement 
# ======================

# Set XDG paths (critical for clean $HOME)
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# Ensure directories exist
mkdir -p "$XDG_DATA_HOME" "$XDG_CONFIG_HOME" "$XDG_STATE_HOME" "$XDG_CACHE_HOME"

# ======================
# ZSH Configuration
# ======================

# History settings (XDG-compliant)
export HISTFILE="${XDG_STATE_HOME}/zsh/history"  # Fixed path conflict (removed duplicate)
HISTSIZE=10000
SAVEHIST=5000
setopt inc_append_history

# Completion cache (XDG-compliant)
export ZSH_COMPDUMP="${XDG_CACHE_HOME}/zsh/zcompdump-${ZSH_VERSION}"
mkdir -p "${XDG_CACHE_HOME}/zsh"

# ======================
# Shell Initialization
# ======================

# Initialize completions (with XDG path)
autoload -Uz compinit
compinit -d "${ZSH_COMPDUMP}"  # Explicitly use our custom path

# Load plugins (with existence checks)
plugin_dir="/usr/share/zsh/plugins"
[ -f "$plugin_dir/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && \
    source "$plugin_dir/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
[ -f "$plugin_dir/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && \
    source "$plugin_dir/zsh-autosuggestions/zsh-autosuggestions.zsh"

# Initialize tools
eval "$(starship init zsh)"  # Prompt
eval "$(zoxide init zsh)"    # Directory navigation

# FZF (fuzzy finder)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ======================
# Environment Variables
# ======================

# Editors
export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"
export MANPAGER='nvim +Man!'

# PATH modifications
export PATH="$HOME/.local/bin:$PATH"

# Application-specific XDG paths
export CARGO_HOME="$XDG_DATA_HOME/cargo"               # Rust
export GNUPGHOME="$XDG_DATA_HOME/gnupg"                # GnuPG
export PYTHONHISTORY="$XDG_STATE_HOME/python/history"  # Python

# ========
# Aliases 
# ========

# System
alias sudo='sudo '  # Allow sudo with aliases
alias rb='reboot'
alias updatemirrors='sudo reflector --verbose --country Australia --protocol https --sort rate --save /etc/pacman.d/mirrorlist'
alias cleanflatpak='flatpak uninstall --unused && flatpak repair'

# Package Management
alias yay='paru'
alias pacman='sudo pacman'

# Files
alias cp='cp -i'
alias mv='mv -i'
alias rm='trash -v'  # Requires trash-cli
alias mkdir='mkdir -p'
alias ls='ls --color=auto'
alias lsh='ls -A'

# Apps
alias nv='nvim'
alias y='yazi'
alias top='btop'
alias cls='clear'
alias kssh='kitty +kitten ssh'
alias songrec='flatpak run com.github.marinm.songrec'

# Configs
alias zshrc='nvim ~/.zshrc'
alias hypr='nvim ~/.config/hypr/hyprland.conf'
alias grub='sudo nvim /etc/default/grub'

# ======================
# Auto-Start Hyprland
# ======================

if [ "$(tty)" = "/dev/tty1" ] && ! systemd-detect-virt -q; then
    exec Hyprland
fi
