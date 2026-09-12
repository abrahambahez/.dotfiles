#!/usr/bin/env bash

get_aur_helper() {
    if command -v yay &>/dev/null; then
        echo "yay"
    elif command -v paru &>/dev/null; then
        echo "paru"
    fi
}

install_aur_packages() {
    local aur_file="$1"

    if [[ ! -f "$aur_file" ]]; then
        log_error "AUR list file not found: $aur_file"
        return 1
    fi

    local helper
    helper=$(get_aur_helper)

    if [[ -z "$helper" ]]; then
        log_error "No AUR helper found (yay/paru). Install one first, then re-run this script."
        return 1
    fi

    log_info "Installing AUR packages from: $aur_file (using $helper)"

    local packages
    packages=$(read_list_file "$aur_file")

    if [[ -z "$packages" ]]; then
        log_info "No AUR packages to install"
        return 0
    fi

    local package
    while IFS= read -r package; do
        if pacman -Qi "$package" &>/dev/null; then
            log_info "Package already installed: $package"
        else
            run_command "Install AUR package: $package" "$helper" -S --noconfirm "$package"
        fi
    done <<< "$packages"
}
