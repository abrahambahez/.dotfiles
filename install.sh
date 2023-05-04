#!/usr/bin/env bash

# Check dependencies git stow, antibody

for i in stow antibody nvim zsh kitty 
do 
    if ! command -v $i &> /dev/null
    then
        echo "$i could not be found; install it"
        exit
    else
        echo "$i is installed"
    fi
done

# Stow

stow nvim
stow zsh
stow kitty

# Install antibody
# Linux 
# curl -sfL git.io/antibody | sh -s - -b /usr/local/bin
# MacOs
# brew install antibody

# Use antibody
antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh

# Source antibody file to .zshrc
echo "# Dotfiles auto sourcing \nsource ~/.zah_plugins.sh" | tee -a .zshrc


