#!/usr/bin/env bash

echo "🖥 Instalando apps"

su

# Apps needed by karma

# Mongo

echo "Instalando MongoDB Compass"
cd ~/Descargas && wget https://downloads.mongodb.com/compass/mongodb-compass-1.41.0.x86_64.rpm
sudo rpm -i ~/Descargas/mongodb-compass-1.41.0.x86_64.rpm

echo "Instalando Slack"
flatpak install flathub com.slack.Slack
