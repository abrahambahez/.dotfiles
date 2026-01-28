#!/usr/bin/env bash

install_fonts() {
    local fonts_file="$1"

    if [[ ! -f "$fonts_file" ]]; then
        log_error "Fonts list file not found: $fonts_file"
        return 1
    fi

    log_info "Installing fonts from: $fonts_file"

    local entries
    entries=$(read_list_file "$fonts_file")

    if [[ -z "$entries" ]]; then
        log_info "No fonts to install"
        return 0
    fi

    local entry font_name font_type font_url
    while IFS= read -r entry; do
        font_name=$(echo "$entry" | cut -d'|' -f1 | xargs)
        font_type=$(echo "$entry" | cut -d'|' -f2 | xargs)
        font_url=$(echo "$entry" | cut -d'|' -f3 | xargs)

        if [[ -z "$font_name" ]] || [[ -z "$font_type" ]] || [[ -z "$font_url" ]]; then
            log_error "Invalid font entry format: $entry (expected: name|type|url)"
            continue
        fi

        case "$font_type" in
            zip)
                install_font_from_zip "$font_name" "$font_url"
                ;;
            ttf|otf)
                install_font_direct "$font_name" "$font_url"
                ;;
            *)
                log_error "Unknown font type: $font_type for $font_name"
                ;;
        esac
    done <<< "$entries"
}

install_font_from_zip() {
    local font_name="$1"
    local font_url="$2"
    local font_dir="$HOME/.local/share/fonts/$font_name"

    log_info "Installing font: $font_name (zip)"

    if [[ -d "$font_dir" ]] && [[ -n "$(ls -A "$font_dir" 2>/dev/null)" ]]; then
        log_info "Font already installed: $font_name"
        return 0
    fi

    mkdir -p "$font_dir" || {
        log_error "Failed to create font directory: $font_dir"
        return 1
    }

    local temp_zip="$font_dir/$(basename "$font_url")"

    if wget -O "$temp_zip" "$font_url" >> "$LOGFILE" 2>&1; then
        log_success "Downloaded font: $font_name"
        if unzip -o "$temp_zip" -d "$font_dir" >> "$LOGFILE" 2>&1; then
            log_success "Extracted font: $font_name"
            rm -f "$temp_zip"
            return 0
        else
            log_error "Failed to extract font: $font_name"
            rm -f "$temp_zip"
            return 1
        fi
    else
        log_error "Failed to download font: $font_name"
        return 1
    fi
}

install_font_direct() {
    local font_name="$1"
    local font_url="$2"
    local font_dir="$HOME/.local/share/fonts/$font_name"

    log_info "Installing font: $font_name (direct)"

    mkdir -p "$font_dir" || {
        log_error "Failed to create font directory: $font_dir"
        return 1
    }

    local font_file="$font_dir/$(basename "$font_url")"

    if [[ -f "$font_file" ]]; then
        log_info "Font file already exists: $font_name"
        return 0
    fi

    if wget -P "$font_dir" "$font_url" >> "$LOGFILE" 2>&1; then
        log_success "Downloaded font: $font_name - $(basename "$font_url")"
        return 0
    else
        log_error "Failed to download font: $font_name - $(basename "$font_url")"
        return 1
    fi
}
