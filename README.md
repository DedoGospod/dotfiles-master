# dotfiles-master
My personal dotfiles

Install instructions (Arch)
1. git clone https://github.com/dedogospod/dotfiles-master.git
2. pacman -S stow
3. cd dotfiles-master
4. stow (program) eg. stow kitty

If any error messages occur, delete the pre-existing config with the following command: 
"rm -rf (config)" eg. rm -rf .config/kitty/kitty.conf 

once the directory is deleted then use the stow command again eg. stow kitty
