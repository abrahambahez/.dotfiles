#!/usr/bin/env bash

setup_zsh() {
    log_info "Configuring zsh as default shell"

    if ! command -v zsh &>/dev/null; then
        log_error "zsh not installed, skipping shell configuration"
        return 1
    fi

    local zsh_path
    zsh_path=$(command -v zsh)

    local current_shell
    current_shell=$(getent passwd "$USER" | cut -d: -f7)

    if [[ "$current_shell" == "$zsh_path" ]]; then
        log_info "zsh already set as default shell for $USER"
        return 0
    fi

    if ! grep -q "$zsh_path" /etc/shells 2>/dev/null; then
        if echo "$zsh_path" | sudo tee -a /etc/shells >> "$LOGFILE" 2>&1; then
            log_success "Added zsh to /etc/shells"
        else
            log_error "Failed to add zsh to /etc/shells"
            return 1
        fi
    else
        log_info "zsh already in /etc/shells"
    fi

    if run_command "Set zsh as default shell for $USER" sudo chsh -s "$zsh_path" "$USER"; then
        run_command "Set zsh as default shell for current session" chsh -s "$zsh_path"
    fi
}

install_antidote() {
    log_info "Installing antidote zsh plugin manager"

    local antidote_dir="${ZDOTDIR:-$HOME}/.antidote"

    if [[ -f "$antidote_dir/antidote.zsh" ]]; then
        log_info "antidote already installed, skipping"
        return 0
    fi

    run_command "Clone antidote" \
        git clone --depth=1 https://github.com/mattmc3/antidote.git "$antidote_dir"
}

install_uv_python() {
    log_info "Installing UV Python manager"

    if command -v uv &>/dev/null; then
        log_info "UV already installed, skipping"
        return 0
    fi

    if curl -LsSf https://astral.sh/uv/install.sh 2>> "$LOGFILE" | sh >> "$LOGFILE" 2>&1; then
        log_success "UV Python installer completed"
        if command -v uv &>/dev/null; then
            run_command "Install Python via UV" uv python install
        else
            log_error "UV installed but not found in PATH"
            return 1
        fi
    else
        log_error "Failed to install UV Python"
        return 1
    fi
}

logout_session() {
    if command -v hyprctl &>/dev/null; then
        log_info "Logging out in 10 seconds... (Ctrl+C to cancel)"
        sleep 10
        hyprctl dispatch exit
    else
        log_info "Please log out manually to apply all changes"
    fi
}
