#!/usr/bin/env bash

# Make dnf faster appending two lines to the end of the config file
sudo echo "max_parallel_downloads=10" >> /etc/dnf/dnf.conf
sudo echo "fastestmirror=True" >> /etc/dnf/dnf.conf

echo "Actualizando sistema"
sudo dnf update

echo "Instalando software inicial"
sudo dnf install -y zsh neovim stow kitty ImageMagick gnome-shell-extension-pop-shell xprop curl wget util-linux-user fzf fd-find pandoc g++ timeshift # If treesitter compiling throws error: install g++

# It can be uninstalled: about:support in Firefox > Application Basics > Profile Directory > Open Directory — and delete the “chrome” folder.
#echo "Instalando script para tema en Firefox"
#curl -s -o- https://raw.githubusercontent.com/rafaelmardojai/firefox-gnome-theme/master/scripts/install-by-curl.sh | bash

# Install TinyTex
echo "Instalando TinyTex para conversión pandoc-pdf"
wget -qO- "https://yihui.org/tinytex/install-bin-unix.sh" | sh

# Add Flathub repo
echo "Instalando repositorio Flathub"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Install Obsidian & Zotero
echo "Instalando software desde Flathub"
flatpak install -y flathub md.obsidian.Obsidian org.zotero.Zotero com.spotify.Client

# Set adwaita-dark theme for Zotero
sudo flatpak override --env=GTK_THEME=Adwaita-dark org.zotero.Zotero

# Download Hack Nerd Font
echo "Instalando tipografía: Hack Nerd Font"
mkdir ~/.local/share/fonts/Hack/
cd ~/.local/share/fonts/Hack/
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.0/Hack.zip 
sudo unzip ~/.local/share/fonts/Hack.zip
ls -la ~/.local/share/fonts/
#sudo rm ~/.local/share/fonts/Hack.zip

# Download iAWriterDuo
echo "Instalando tipografía: iA Writer Duo"
mkdir -p ~/.local/share/fonts/iAWriterDuo/
cd ~/.local/share/fonts/iAWriterDuo/
wget https://github.com/iaolo/iA-Fonts/raw/master/iA%20Writer%20Duo/Variable/iAWriterDuoV.ttf
wget https://github.com/iaolo/iA-Fonts/raw/master/iA%20Writer%20Duo/Variable/iAWriterDuoV-Italic.ttf

echo "Instalando tipografía: Inter"
mkdir -p ~/.local/share/fonts/Inter/
cd ~/.local/share/fonts/Inter/
wget https://github.com/rsms/inter/releases/download/v3.19/Inter-3.19.zip
sudo unzip ~/.local/share/fonts/Inter/Inter-3.19.zip

cd ~
# add zsh as a login shell
echo "Configurando zsh como shell principal"
command -v zsh | sudo tee -a /etc/shells

# use zsh as default shell
sudo chsh -s $(which zsh) $USER
chsh -s $(which zsh)

# Install antibody
echo "Instalando antibody zsh manager"
sudo curl -sfL git.io/antibody | sudo sh -s - -b /usr/local/bin

# Run script to change kitty icons
echo "Cambiando íconos de Kitty terminal"
sudo chmod +x ~/.dotfiles/scripts/fdr_kitty_logo.sh
~/.dotfiles/scripts/fdr_kitty_logo.sh

echo "Proceso terminado.\n\nConfigura últimos retoques vía GUI: Gnome Tweaks + Shell extensions\n\nSe cerrará la sesión..."

gnome-session-quit --logout

