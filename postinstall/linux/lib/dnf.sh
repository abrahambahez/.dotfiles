#!/usr/bin/env bash

setup_dnf_config() {
    log_info "Configuring DNF for faster downloads"

    if grep -q "max_parallel_downloads" /etc/dnf/dnf.conf 2>/dev/null; then
        log_info "DNF already configured, skipping"
        return 0
    fi

    if echo "max_parallel_downloads=10" | sudo tee -a /etc/dnf/dnf.conf >> "$LOGFILE" 2>&1 && \
       echo "fastestmirror=True" | sudo tee -a /etc/dnf/dnf.conf >> "$LOGFILE" 2>&1; then
        log_success "DNF configuration updated"
        return 0
    else
        log_error "Failed to configure DNF"
        return 1
    fi
}

update_system() {
    run_command "System update (dnf update)" sudo dnf update -y
}

install_dnf_packages() {
    local packages_file="$1"

    if [[ ! -f "$packages_file" ]]; then
        log_error "Package list file not found: $packages_file"
        return 1
    fi

    log_info "Installing DNF packages from: $packages_file"

    local packages
    packages=$(read_list_file "$packages_file")

    if [[ -z "$packages" ]]; then
        log_info "No packages to install"
        return 0
    fi

    local package
    while IFS= read -r package; do
        if rpm -q "$package" &>/dev/null; then
            log_info "Package already installed: $package"
        else
            run_command "Install DNF package: $package" sudo dnf install -y "$package"
        fi
    done <<< "$packages"
}
