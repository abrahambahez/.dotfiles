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

# Use antibody
# Consider change antibody for antidote (newer implementation) https://github.com/mattmc3/antidote
antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh

echo "Success: Dotfiles stowed and zsh plugins installed"
