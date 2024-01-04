#!/bin/sh
sudo

# Install rofimoji
echo "📦 Instalando soporte para emojis en rofi (rofimoji)"
dnf install rofimoji

# Build rofi-calc from source
echo "📦 Instalando calculadora para rofi desde el repositorio"
# Install dependencies
sudo dnf install qalculate automake libtool rofi-devel -y

cd ~
git clone https://github.com/svenstaro/rofi-calc.git
mkdir m4
autoreconf -i
mkdir build
cd build/
../configure
make
make install

echo "✅ rofi-calc instalado"

echo "Proceso terminado 🤓"
