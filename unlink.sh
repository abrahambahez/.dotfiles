#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"  # Ensure we are in ~/.dotfiles

CONFIG_TARGET="$HOME/.config"
HOME_TARGET="$HOME"

# Same config directories used in link.sh
CONFIG_DIRS=(
  espanso
  ghostty
  kitty
  nvim
  rofi
  uv
)

echo "🗑️ Unlinking config directories from $CONFIG_TARGET..."
for dir in "${CONFIG_DIRS[@]}"; do
  dest="$CONFIG_TARGET/$dir"

  if [[ -L "$dest" ]]; then
    echo " • Removing symlink: $dest"
    rm "$dest"
  elif [[ -e "$dest" ]]; then
    echo " ⚠️ Warning: $dest exists but is not a symlink. Skipping."
  fi
done

echo "🗑️ Unlinking files in zsh/ from $HOME_TARGET..."
find zsh -maxdepth 1 -type f | while read -r filepath; do
  filename="$(basename "$filepath")"
  dest="$HOME_TARGET/$filename"

  if [[ -L "$dest" ]]; then
    echo " • Removing symlink: $dest"
    rm "$dest"
  elif [[ -e "$dest" ]]; then
    echo " ⚠️ Warning: $dest exists but is not a symlink. Skipping."
  fi
done

echo "✅ All symlinks removed (where applicable)."
