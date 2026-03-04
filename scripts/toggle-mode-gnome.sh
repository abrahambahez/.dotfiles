#!/bin/bash

BG_DIR="$HOME/Imágenes/bg"

random_wallpaper() {
    local dir="$BG_DIR/$1"
    local files=("$dir"/*.png "$dir"/*.jpg)
    local valid=()
    for f in "${files[@]}"; do [[ -f "$f" ]] && valid+=("$f"); done
    [[ ${#valid[@]} -eq 0 ]] && { echo "Error: no images in $dir" >&2; exit 1; }
    echo "${valid[$RANDOM % ${#valid[@]}]}"
}

current_color_scheme=$(gsettings get org.gnome.desktop.interface color-scheme)

if [[ "$current_color_scheme" == "'prefer-dark'" ]]; then
    wallpaper=$(random_wallpaper light)
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
    gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita'
    gsettings set org.gnome.desktop.wm.preferences theme 'Adwaita'
else
    wallpaper=$(random_wallpaper dark)
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
    gsettings set org.gnome.desktop.wm.preferences theme 'Adwaita-dark'
fi

gsettings set org.gnome.desktop.background picture-uri "file://$wallpaper"
gsettings set org.gnome.desktop.background picture-uri-dark "file://$wallpaper"
