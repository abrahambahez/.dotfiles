#!/usr/bin/env bash

# Set base directory and positional argumen variable
sourceDir=~/.dotfiles/obsidian/

# If no positional argument is given, set destination to working directory
if [ -z "$1" ]; then
    targetDir=$(pwd)
else
    targetDir=$1
fi

# Copy base directories
cp -r $sourceDir.obsidian/* $targetDir
cp -r $sourceDir.pandoc/ $targetDir
cp "$sourceDir"gitignore $targetDir.gitignore

# Create Symlinks
ln "$sourceDir"hotkeys.json $targetDir/.obsidian/
ln "$sourceDir".obsidian.vimrc $targetDir
ln "$sourceDir"librero.bib $targetDir
echo "🪨 Terminado"
