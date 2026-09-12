#!/usr/bin/env bash

setup_pacman_config() {
    log_info "Configuring pacman for faster, friendlier output"

    local conf="/etc/pacman.conf"
    local changed=0

    if ! grep -q "^Color" "$conf" 2>/dev/null; then
        run_command "Enable Color in pacman.conf" \
            sudo sed -i 's/^#Color/Color/' "$conf" && changed=1
    else
        log_info "pacman Color already enabled"
    fi

    if ! grep -q "^ParallelDownloads" "$conf" 2>/dev/null; then
        run_command "Enable ParallelDownloads in pacman.conf" \
            sudo sed -i 's/^#ParallelDownloads.*/ParallelDownloads = 10/' "$conf" && changed=1
    else
        log_info "pacman ParallelDownloads already configured"
    fi

    if [[ $changed -eq 0 ]]; then
        log_info "pacman already configured, skipping"
    fi
}

update_system() {
    run_command "System update (pacman -Syu)" sudo pacman -Syu --noconfirm
}

install_pacman_packages() {
    local packages_file="$1"

    if [[ ! -f "$packages_file" ]]; then
        log_error "Package list file not found: $packages_file"
        return 1
    fi

    log_info "Installing pacman packages from: $packages_file"

    local packages
    packages=$(read_list_file "$packages_file")

    if [[ -z "$packages" ]]; then
        log_info "No packages to install"
        return 0
    fi

    local package
    while IFS= read -r package; do
        if pacman -Qi "$package" &>/dev/null; then
            log_info "Package already installed: $package"
        else
            run_command "Install pacman package: $package" sudo pacman -S --noconfirm "$package"
        fi
    done <<< "$packages"
}
