#!/usr/bin/env bash

# Set base directory and positional argumen variable
sourceDir=~/archivo/notas/

# If no positional argument is given, set destination to working directory
if [ -z "$1" ]; then
    targetDir="$(pwd)/"
else
    targetDir=$1
fi

# Copy base directories [Temporally suspend feature]
#cp -r $sourceDir.obsidian/ $targetDir
#cp -r $sourceDir.pandoc/ $targetDir

# Create Symlinks
ln -s "$sourceDir".obsidian/hotkeys.json $targetDir/.obsidian/
ln -s "$sourceDir".obsidian.vimrc $targetDir
ln -s "$sourceDir"librero.bib $targetDir
echo "🪨 Terminado"
