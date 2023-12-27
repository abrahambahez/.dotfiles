 # Welcome to my dotfiles

 Simple personal dotfiles repo using stow to manage config files across Macos and Linux.

## Using stow with this tree structure

Make sure you follow the tree structure pattern.
If you're in `.dotfiles/` then:

```bash
stow -t "$HOME" PACKAGE
```

example: `stow -t "$HOME" rofi`

