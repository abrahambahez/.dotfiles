#!/usr/bin/env bash

setup_flathub() {
    log_info "Setting up Flathub repository"

    if flatpak remote-list | grep -q "flathub" 2>/dev/null; then
        log_info "Flathub already configured"
        return 0
    fi

    run_command "Add Flathub repository" \
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
}

install_flatpak_apps() {
    local flatpak_file="$1"

    if [[ ! -f "$flatpak_file" ]]; then
        log_error "Flatpak list file not found: $flatpak_file"
        return 1
    fi

    if ! command -v flatpak &>/dev/null; then
        log_error "Flatpak not installed, skipping Flatpak apps"
        return 1
    fi

    log_info "Installing Flatpak apps from: $flatpak_file"

    local apps
    apps=$(read_list_file "$flatpak_file")

    if [[ -z "$apps" ]]; then
        log_info "No Flatpak apps to install"
        return 0
    fi

    local app
    while IFS= read -r app; do
        if flatpak list --app | grep -q "$app" 2>/dev/null; then
            log_info "Flatpak app already installed: $app"
        else
            run_command "Install Flatpak app: $app" flatpak install -y flathub "$app"
        fi
    done <<< "$apps"
}
