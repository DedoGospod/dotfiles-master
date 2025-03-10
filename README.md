Dotfiles Installation Guide (Arch Linux)

1. Clone the Dotfiles Repository: Open your terminal and run the following command to clone my dotfiles repository:

git clone https://github.com/dedogospod/dotfiles-master.git

2. Install stow: stow is a tool to manage symlinks for your dotfiles. Install it using:

sudo pacman -S stow

3. Navigate to the Dotfiles Directory:

cd dotfiles-master

4. Apply Dotfiles for a Specific Program: Use stow to create symlinks for the configuration of a specific program. For example, to set up kitty configurations, run:

stow kitty

5. Resolve Conflicts (if any): If you encounter errors due to pre-existing configuration files, remove the conflicting files or directories. For example, if kitty's config conflicts, run:

rm -rf ~/.config/kitty/kitty.conf

6. Then, re-run the stow command:

stow kitty

7. Repeat for Other Programs: Repeat the stow command for other programs as needed. For example:

stow nvim                                                                                        
stow zsh
