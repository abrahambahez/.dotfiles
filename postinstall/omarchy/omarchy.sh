#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$SCRIPT_DIR/lib"
DATA_DIR="$SCRIPT_DIR/data"
CONFIG_DIR="$SCRIPT_DIR/config"

source "$LIB_DIR/core.sh"
source "$LIB_DIR/pacman.sh"
source "$LIB_DIR/aur.sh"
source "$LIB_DIR/fonts.sh"
source "$LIB_DIR/extras.sh"

if [[ -f "$CONFIG_DIR/settings.env" ]]; then
    source "$CONFIG_DIR/settings.env"
fi

SKIP_SYSTEM_UPDATE="${SKIP_SYSTEM_UPDATE:-false}"
SKIP_ZSH_SETUP="${SKIP_ZSH_SETUP:-false}"
SKIP_UV_PYTHON="${SKIP_UV_PYTHON:-false}"
AUTO_LOGOUT="${AUTO_LOGOUT:-true}"

log_info "=== Omarchy Post-Install Script Started ==="
log_info "Log file: $LOGFILE"
log_info "Script directory: $SCRIPT_DIR"

if ! pre_flight_checks; then
    log_error "Pre-flight checks failed. Exiting."
    exit 1
fi

setup_pacman_config

if [[ "$SKIP_SYSTEM_UPDATE" != "true" ]]; then
    update_system
else
    log_info "Skipping system update (SKIP_SYSTEM_UPDATE=true)"
fi

if [[ -f "$DATA_DIR/pacman-packages.txt" ]]; then
    install_pacman_packages "$DATA_DIR/pacman-packages.txt"
fi

if [[ -f "$DATA_DIR/aur-packages.txt" ]]; then
    install_aur_packages "$DATA_DIR/aur-packages.txt"
fi

if [[ "$SKIP_ZSH_SETUP" != "true" ]]; then
    setup_zsh
else
    log_info "Skipping zsh setup (SKIP_ZSH_SETUP=true)"
fi

if [[ "$SKIP_UV_PYTHON" != "true" ]]; then
    install_uv_python
else
    log_info "Skipping UV Python (SKIP_UV_PYTHON=true)"
fi

if [[ -f "$DATA_DIR/fonts.txt" ]]; then
    install_fonts "$DATA_DIR/fonts.txt"
fi

print_summary

if [[ "$AUTO_LOGOUT" == "true" ]]; then
    logout_session
else
    log_info "Auto-logout disabled (AUTO_LOGOUT=false)"
fi
