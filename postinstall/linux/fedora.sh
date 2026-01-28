#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$SCRIPT_DIR/lib"
DATA_DIR="$SCRIPT_DIR/data"
CONFIG_DIR="$SCRIPT_DIR/config"

source "$LIB_DIR/core.sh"
source "$LIB_DIR/dnf.sh"
source "$LIB_DIR/copr.sh"
source "$LIB_DIR/flatpak.sh"
source "$LIB_DIR/fonts.sh"
source "$LIB_DIR/git-extensions.sh"
source "$LIB_DIR/gnome-keyboard.sh"
source "$LIB_DIR/extras.sh"

if [[ -f "$CONFIG_DIR/settings.env" ]]; then
    source "$CONFIG_DIR/settings.env"
fi

ULAUNCHER_EXTENSIONS_DIR="${ULAUNCHER_EXTENSIONS_DIR:-$HOME/.local/share/ulauncher/extensions}"
SKIP_SYSTEM_UPDATE="${SKIP_SYSTEM_UPDATE:-false}"
SKIP_ZSH_SETUP="${SKIP_ZSH_SETUP:-false}"
SKIP_UV_PYTHON="${SKIP_UV_PYTHON:-false}"
SKIP_HOMEBREW="${SKIP_HOMEBREW:-false}"
SKIP_GNOME_CONFIG="${SKIP_GNOME_CONFIG:-false}"
AUTO_LOGOUT="${AUTO_LOGOUT:-true}"

log_info "=== Fedora Post-Install Script Started ==="
log_info "Log file: $LOGFILE"
log_info "Script directory: $SCRIPT_DIR"

if ! pre_flight_checks; then
    log_error "Pre-flight checks failed. Exiting."
    exit 1
fi

setup_dnf_config

if [[ "$SKIP_SYSTEM_UPDATE" != "true" ]]; then
    update_system
else
    log_info "Skipping system update (SKIP_SYSTEM_UPDATE=true)"
fi

if [[ -f "$DATA_DIR/dnf-packages.txt" ]]; then
    install_dnf_packages "$DATA_DIR/dnf-packages.txt"
fi

if [[ -f "$DATA_DIR/copr-packages.txt" ]]; then
    install_copr_packages "$DATA_DIR/copr-packages.txt"
fi

if [[ -f "$DATA_DIR/flatpak-apps.txt" ]]; then
    setup_flathub
    install_flatpak_apps "$DATA_DIR/flatpak-apps.txt"
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

if [[ "$SKIP_HOMEBREW" != "true" ]]; then
    install_homebrew
else
    log_info "Skipping Homebrew (SKIP_HOMEBREW=true)"
fi

if [[ "$SKIP_GNOME_CONFIG" != "true" ]]; then
    configure_gnome_keyboard
else
    log_info "Skipping GNOME keyboard configuration (SKIP_GNOME_CONFIG=true)"
fi

if [[ -f "$DATA_DIR/fonts.txt" ]]; then
    install_fonts "$DATA_DIR/fonts.txt"
fi

if [[ -f "$DATA_DIR/ulauncher-extensions.txt" ]]; then
    install_git_extensions "$DATA_DIR/ulauncher-extensions.txt" "$ULAUNCHER_EXTENSIONS_DIR"
fi

print_summary

if [[ "$AUTO_LOGOUT" == "true" ]]; then
    logout_session
else
    log_info "Auto-logout disabled (AUTO_LOGOUT=false)"
fi
