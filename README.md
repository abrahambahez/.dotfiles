# Welcome to my dotfiles

This dotfiles configuration uses a simple `link.sh` script to create symlinks either in the user root or in `.config` folder.

It also contains an `unlink.sh` script to remove the symlinks.

The scripts are manually mantained.

## Notes

- ZSH uses
    - [Antidote](https://antidote.sh/)
    - [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- Neovim uses
    - [Kickstart Neovim](https://github.com/nvim-lua/kickstart.nvim/tree/master)
- Ghostty is my current terminal of choice


## Post-install scripts
The post-install directory contains scripts to setup a new installation, based on my shred preferences:
- `linux/`: Fedora (DNF/COPR/GNOME)
- `macos/`: macOS (Homebrew)
- `omarchy/`: Omarchy/Arch Linux (pacman/AUR/Hyprland)

## General-purpose Scripts

Scripts directory can be symlinked locally to `.local/bin`.

Use the `link-scripts.sh` script to do it. Use `unlink-scripts.sh` to remove the symlinks.

## Other shared files

Also having templates for reusing structures.
