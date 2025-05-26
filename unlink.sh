#!/usr/bin/env bash
set -e

cd "$(dirname "$0")"

# Unstow packages under .config from $HOME/.config
CONFIG_PACKAGES=(
  espanso
  ghostty
  kitty
  nvim
  rofi
  uv
)

for pkg in "${CONFIG_PACKAGES[@]}"; do
  echo "Unstowing .config/$pkg from $HOME/.config"
  stow --dir=.config --target="$HOME/.config" --verbose -D "$pkg"
done

# Unstow home-level dotfiles (like .zshrc) from $HOME
HOME_PACKAGES=(
  zsh
)

for pkg in "${HOME_PACKAGES[@]}"; do
  echo "Unstowing $pkg from $HOME"
  stow --target="$HOME" --verbose -D "$pkg"
done

