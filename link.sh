#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"  # Ensure we are in ~/.dotfiles

CONFIG_TARGET="$HOME/.config"
HOME_TARGET="$HOME"

# List of directories to link into $HOME/.config
CONFIG_DIRS=(
  espanso
  ghostty
  kitty
  nvim
  rofi
  uv
  todotxt
)

echo "🔗 Linking config directories to $CONFIG_TARGET..."
for dir in "${CONFIG_DIRS[@]}"; do
  src="$(pwd)/$dir"
  dest="$CONFIG_TARGET/$dir"

  echo " • $src → $dest"
  mkdir -p "$(dirname "$dest")"
  rm -rf "$dest"
  ln -s "$src" "$dest"
done

echo "🔗 Linking all files in zsh/ to $HOME_TARGET..."
find zsh -maxdepth 1 -type f | while read -r filepath; do
  filename="$(basename "$filepath")"
  src="$(pwd)/$filepath"
  dest="$HOME_TARGET/$filename"

  echo " • $src → $dest"
  rm -f "$dest"
  ln -s "$src" "$dest"
done

echo "✅ All symlinks created successfully."

