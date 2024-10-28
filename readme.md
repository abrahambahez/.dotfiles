 # Welcome to my dotfiles

 Simple personal dotfiles repo using stow to manage config files across Macos and Linux.

## Using stow with this tree structure

Make sure you follow the tree structure pattern.
If you're in `.dotfiles/` then:

```bash
stow -t "$HOME" PACKAGE
```

example: `stow -t "$HOME" rofi`

## Features

### ZSH

La configuración de zsh usa [oh-my-zsh](https://ohmyz.sh/) para los temas.
También usa [antibidy](https://getantibody.github.io/) como *plugin manager*.

### Neovim

Neovim usa [Kickstart Neovim](https://github.com/nvim-lua/kickstart.nvim/tree/master) como base para el editor.
