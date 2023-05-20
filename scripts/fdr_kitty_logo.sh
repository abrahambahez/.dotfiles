#!/usr/bin/env bash

echo "Cambiando ícono de Kitty para Fedora\n"

cd ~
wget https://raw.githubusercontent.com/k0nserv/kitty-icon/main/build/neue_outrun.iconset/icon_128x128.png

sudo mv ~/icon_128x128.png /usr/lib64/kitty/logo/kitty.png

wget https://raw.githubusercontent.com/k0nserv/kitty-icon/main/build/neue_outrun.iconset/icon_128x128.png

sudo mv ~/icon_128x128.png /usr/share/app-info/icons/fedora/128x128/kitty.png

wget https://raw.githubusercontent.com/k0nserv/kitty-icon/main/build/neue_outrun.iconset/icon_32x32%402x.png

sudo mv ~/icon_32x32@2x.png /usr/share/app-info/icons/fedora/64x64/kitty.png

wget https://raw.githubusercontent.com/k0nserv/kitty-icon/main/build/neue_outrun.iconset/icon_256x256.png

sudo mv ~/icon_256x256.png /usr/share/icons/hicolor/256x256/apps/kitty.png

# Set icon in .desktop file

echo "Cambiando logo en el archivo .desktop\nReferencia:"
cat /usr/share/applications/kitty.desktop

echo "Se usará el siguiente ícono:"
kitty icat /usr/share/icons/hicolor/256x256/apps/kitty.png

sudo sed -i '/Icon=kitty/c\Icon=/usr/share/icons/hicolor/256x256/apps/kitty.png' /usr/share/applications/kitty.desktop

cat /usr/share/applications/kitty.desktop

sudo sed -i '/Icon=kitty/c\Icon=/usr/share/icons/hicolor/256x256/apps/kitty.png' /usr/share/applications/kitty-open.desktop

cat /usr/share/applications/kitty-open.desktop

echo "Proceso terminado"

