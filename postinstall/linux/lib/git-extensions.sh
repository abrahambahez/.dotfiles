#!/usr/bin/env bash

get_ulauncher_extension_name() {
    local url="$1"

    local user repo
    user=$(echo "$url" | sed -n 's|.*/github.com/\([^/]*\)/.*|\1|p')
    repo=$(basename "$url" .git)

    if [[ -z "$user" ]] || [[ -z "$repo" ]]; then
        echo "$repo"
        return 1
    fi

    echo "com.github.${user}.${repo}"
    return 0
}

install_git_extensions() {
    local extensions_file="$1"
    local target_dir="$2"

    if [[ ! -f "$extensions_file" ]]; then
        log_error "Extensions list file not found: $extensions_file"
        return 1
    fi

    if [[ -z "$target_dir" ]]; then
        log_error "Target directory not specified for git extensions"
        return 1
    fi

    if ! command -v git &>/dev/null; then
        log_error "Git not installed, skipping git extensions"
        return 1
    fi

    log_info "Installing git extensions from: $extensions_file"
    log_info "Target directory: $target_dir"

    mkdir -p "$target_dir" || {
        log_error "Failed to create extensions directory: $target_dir"
        return 1
    }

    local urls
    urls=$(read_list_file "$extensions_file")

    if [[ -z "$urls" ]]; then
        log_info "No git extensions to install"
        return 0
    fi

    local url extension_name
    while IFS= read -r url; do
        extension_name=$(get_ulauncher_extension_name "$url")

        if [[ -d "$target_dir/$extension_name" ]]; then
            log_info "Extension already installed: $extension_name"
        else
            run_command "Clone extension: $extension_name" \
                git clone "$url" "$target_dir/$extension_name"
        fi
    done <<< "$urls"
}
