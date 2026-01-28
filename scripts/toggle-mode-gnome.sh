#!/bin/bash

# GNOME Dark/Light Mode & Wallpaper Toggle Script
# Usage: ./toggle-theme.sh

find_wallpaper() {
    local wallpaper_name=$1
    local wallpaper_dir="$HOME/Imágenes"

    if [[ -f "$wallpaper_dir/$wallpaper_name.png" ]]; then
        echo "$wallpaper_dir/$wallpaper_name.png"
    elif [[ -f "$wallpaper_dir/$wallpaper_name.jpg" ]]; then
        echo "$wallpaper_dir/$wallpaper_name.jpg"
    else
        echo ""
    fi
}

LIGHT_WALLPAPER=$(find_wallpaper "bg-light")
DARK_WALLPAPER=$(find_wallpaper "bg-dark")

if [[ -z "$LIGHT_WALLPAPER" ]]; then
    echo "Error: bg-light wallpaper not found (searched for .png and .jpg in $HOME/Imágenes)"
    exit 1
fi

if [[ -z "$DARK_WALLPAPER" ]]; then
    echo "Error: bg-dark wallpaper not found (searched for .png and .jpg in $HOME/Imágenes)"
    exit 1
fi

# Get current theme preference
current_theme=$(gsettings get org.gnome.desktop.interface gtk-theme)
current_color_scheme=$(gsettings get org.gnome.desktop.interface color-scheme)

echo "Current theme: $current_theme"
echo "Current color scheme: $current_color_scheme"

# Toggle theme based on current color scheme
if [[ "$current_color_scheme" == "'prefer-dark'" ]]; then
    # Switch to light mode
    echo "Switching to light mode..."
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
    gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita'
    gsettings set org.gnome.desktop.wm.preferences theme 'Adwaita'
    
    # Set light wallpaper
    gsettings set org.gnome.desktop.background picture-uri "file://$LIGHT_WALLPAPER"
    gsettings set org.gnome.desktop.background picture-uri-dark "file://$LIGHT_WALLPAPER"
    
    echo "✓ Switched to light mode with light wallpaper"
else
    # Switch to dark mode
    echo "Switching to dark mode..."
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
    gsettings set org.gnome.desktop.wm.preferences theme 'Adwaita-dark'
    
    # Set dark wallpaper
    gsettings set org.gnome.desktop.background picture-uri "file://$DARK_WALLPAPER"
    gsettings set org.gnome.desktop.background picture-uri-dark "file://$DARK_WALLPAPER"
    
    echo "✓ Switched to dark mode with dark wallpaper"
fi

echo "Theme toggle complete!"
