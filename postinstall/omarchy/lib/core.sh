#!/usr/bin/env bash

LOGFILE="${LOGFILE:-/tmp/omarchy-postinstall-$(date +%Y%m%d-%H%M%S).log}"
ERROR_COUNT=0
SUCCESS_COUNT=0

log_info() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] [INFO] $*" | tee -a "$LOGFILE"
}

log_success() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] [SUCCESS] $*" | tee -a "$LOGFILE"
    ((SUCCESS_COUNT++))
}

log_error() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] [ERROR] $*" | tee -a "$LOGFILE" >&2
    ((ERROR_COUNT++))
}

run_command() {
    local description="$1"
    shift
    log_info "Starting: $description"

    # Tee (not redirect) stdout/stderr: some commands (sudo, yay, omarchy
    # update) prompt for a password mid-run, and a blind redirect hides that
    # prompt from the terminal while still waiting on stdin for an answer,
    # which looks like a hang. Teeing keeps prompts visible while still
    # logging everything.
    if "$@" > >(tee -a "$LOGFILE") 2> >(tee -a "$LOGFILE" >&2); then
        log_success "$description"
        return 0
    else
        local exit_code=$?
        log_error "$description failed (exit code: $exit_code)"
        echo "[ERROR DETAILS] Command: $*" >> "$LOGFILE"
        return 1
    fi
}

pre_flight_checks() {
    log_info "Running pre-flight checks"

    if ! grep -qi "arch" /etc/os-release 2>/dev/null; then
        log_error "This script is designed for Arch Linux (Omarchy)"
        return 1
    fi

    if ! ping -c 1 archlinux.org &>/dev/null; then
        log_error "No internet connectivity detected"
        return 1
    fi

    if ! sudo -n true 2>/dev/null; then
        log_info "Requesting sudo access"
        sudo -v || {
            log_error "Sudo access required"
            return 1
        }
    fi

    log_success "Pre-flight checks passed"
    return 0
}

print_summary() {
    echo ""
    log_info "=== Installation Summary ==="
    log_info "Successful operations: $SUCCESS_COUNT"
    log_info "Failed operations: $ERROR_COUNT"
    log_info "Full log available at: $LOGFILE"
    echo ""

    if [[ $ERROR_COUNT -gt 0 ]]; then
        log_info "Some operations failed. Review the log file for details."
        echo ""
        log_info "Failed operations:"
        grep "\[ERROR\]" "$LOGFILE" | tail -n 10
    else
        log_success "All operations completed successfully!"
    fi

    echo ""
    log_info "Next steps:"
    log_info "- Review Hyprland keybindings in ~/.config/hypr/ and layer your overrides"
    log_info "- Restart your session for all changes to take effect"
}

read_list_file() {
    local file="$1"

    if [[ ! -f "$file" ]]; then
        return 1
    fi

    grep -v '^\s*#' "$file" | grep -v '^\s*$' | sed 's/\s*#.*$//'
}
