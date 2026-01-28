#!/usr/bin/env bash

LOGFILE="${LOGFILE:-/tmp/fedora-postinstall-$(date +%Y%m%d-%H%M%S).log}"
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

    if "$@" >> "$LOGFILE" 2>&1; then
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

    if ! grep -q "Fedora" /etc/os-release 2>/dev/null; then
        log_error "This script is designed for Fedora Linux"
        return 1
    fi

    if ! ping -c 1 google.com &>/dev/null; then
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
    log_info "- Configure final touches via GUI: GNOME Tweaks + Shell Extensions"
    log_info "- Restart your session for all changes to take effect"
}

read_list_file() {
    local file="$1"

    if [[ ! -f "$file" ]]; then
        return 1
    fi

    grep -v '^\s*#' "$file" | grep -v '^\s*$' | sed 's/\s*#.*$//'
}
