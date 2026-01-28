#!/usr/bin/env bash

install_copr_packages() {
    local copr_file="$1"

    if [[ ! -f "$copr_file" ]]; then
        log_error "COPR list file not found: $copr_file"
        return 1
    fi

    log_info "Installing COPR packages from: $copr_file"

    local entries
    entries=$(read_list_file "$copr_file")

    if [[ -z "$entries" ]]; then
        log_info "No COPR packages to install"
        return 0
    fi

    local entry repo package
    while IFS= read -r entry; do
        repo=$(echo "$entry" | cut -d'|' -f1 | xargs)
        package=$(echo "$entry" | cut -d'|' -f2 | xargs)

        if [[ -z "$repo" ]] || [[ -z "$package" ]]; then
            log_error "Invalid COPR entry format: $entry (expected: repo|package)"
            continue
        fi

        if command -v "$package" &>/dev/null; then
            log_info "COPR package already installed: $package"
            continue
        fi

        if run_command "Enable COPR repository: $repo" sudo dnf copr enable -y "$repo"; then
            run_command "Install COPR package: $package" sudo dnf install -y "$package"
        fi
    done <<< "$entries"
}
