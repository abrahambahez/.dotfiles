#!/usr/bin/env bash
echo "Actualizando sistema"
sudo dnf update

echo "Instalando software inicial"
sudo dnf install -y zsh neovim stow kitty gnome-shell-extension-pop-shell xprop curl wget util-linux-user # If treesitter compiling throws error: install g++

# Add Flathub repo
echo "Instalando repositorio Flathub"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Install Obsidian & Zotero
echo "Instalando software desde Flathub"
flatpak install -y flathub md.obsidian.Obsidian org.zotero.Zotero

# Download Hack Nerd Font
echo "Instalando Hack Nerd Font"
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.0/Hack.zip 
mkdir ~/.local/share/fonts/
sudo mv Hack.zip ~/.local/share/fonts/
sudo unzip ~/.local/share/fonts/Hack.zip
ls -la ~/.local/share/fonts/
sudo rm ~/.local/share/fonts/Hack.zip

# add zsh as a login shell
echo "Configurando zsh como shell principal"
command -v zsh | sudo tee -a /etc/shells

# use zsh as default shell
sudo chsh -s $(which zsh) $USER

# Install antibody
echo "Instalando antibody zsh manager"
sudo curl -sfL git.io/antibody | sudo sh -s - -b /usr/local/bin

echo "Proceso terminado.\n\nConfigura últimos retoques vía GUI: Gnome Tweaks + Shell extensions\n\nSe cerrará la sesión..."

gnome-session-quit --logout
