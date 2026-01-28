#!/usr/bin/env bash

backup_keyboard_config() {
    log_info "Backing up current keyboard configuration"

    local backup_dir="$HOME/.config/gnome-backup"
    local backup_file="$backup_dir/keyboard-backup-$(date +%Y%m%d-%H%M%S).conf"

    mkdir -p "$backup_dir"

    {
        echo "# GNOME Keyboard Configuration Backup"
        echo "# Created: $(date)"
        echo ""
        echo "[Input Sources]"
        echo "xkb-options=$(gsettings get org.gnome.desktop.input-sources xkb-options)"
        echo "sources=$(gsettings get org.gnome.desktop.input-sources sources)"
        echo "xkb-model=$(gsettings get org.gnome.desktop.input-sources xkb-model)"
        echo ""
        echo "[Custom Keybindings]"
        dconf dump /org/gnome/settings-daemon/plugins/media-keys/
        echo ""
        echo "[Window Manager Keybindings]"
        gsettings list-recursively org.gnome.desktop.wm.keybindings | grep -v "@as \[\]"
        echo ""
        echo "[Shell Keybindings]"
        gsettings list-recursively org.gnome.shell.keybindings | grep -v "@as \[\]"
    } > "$backup_file"

    if [[ -f "$backup_file" ]]; then
        log_success "Keyboard configuration backed up to: $backup_file"
        return 0
    else
        log_error "Failed to create backup file"
        return 1
    fi
}

configure_xkb_options() {
    log_info "Configuring XKB keyboard options"

    run_command "Set XKB options (swap Alt/Ctrl, Level 3 shift)" \
        gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:swap_lalt_lctl', 'ctrl:ralt_rctrl', 'lv3:switch']"
}

configure_input_sources() {
    log_info "Configuring keyboard input sources"

    run_command "Set keyboard layout to Latin American" \
        gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'latam')]"

    run_command "Set keyboard model" \
        gsettings set org.gnome.desktop.input-sources xkb-model 'pc105+inet'
}

configure_custom_keybindings() {
    log_info "Configuring custom application keybindings"

    local custom_paths="['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/']"

    run_command "Set custom keybindings paths" \
        gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "$custom_paths"

    run_command "Set Ctrl+Space for Ulauncher" \
        bash -c "gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'ulauncher' && \
                 gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'ulauncher-toggle' && \
                 gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Control>space'"

    run_command "Set Super+Space for Ghostty terminal" \
        bash -c "gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ name 'Terminal' && \
                 gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ command 'ghostty' && \
                 gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ binding '<Super>space'"

    run_command "Set Super+M for toggle mode script" \
        bash -c "gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ name 'Change mode' && \
                 gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ command '.local/bin/toggle-mode-gnome.sh' && \
                 gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ binding '<Super>m'"

    run_command "Set Shift+Super+B for Chromium browser" \
        bash -c "gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/ name 'Second Browser' && \
                 gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/ command 'flatpak run org.chromium.Chromium' && \
                 gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/ binding '<Shift><Super>b'"

    run_command "Set Shift+Super+N for Obsidian note" \
        bash -c "gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/ name 'Open Now note' && \
                 gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/ command 'xdg-open \"obsidian://open?vault=lgm&file=ahora\"' && \
                 gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/ binding '<Shift><Super>n'"
}

configure_wm_keybindings() {
    log_info "Configuring window manager keybindings"

    run_command "Set Ctrl+Q to close windows" \
        gsettings set org.gnome.desktop.wm.keybindings close "['<Control>q']"

    run_command "Set Super+Tab and Alt+Tab for app switching" \
        gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Super>Tab', '<Alt>Tab']"

    run_command "Set workspace switching (Super+1/2/3/4)" \
        bash -c "gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 \"['<Super>1']\" && \
                 gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 \"['<Super>2']\" && \
                 gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 \"['<Super>3']\" && \
                 gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 \"['<Super>4']\""

    run_command "Set workspace navigation (Super+Left/Right)" \
        bash -c "gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left \"['<Super>Left']\" && \
                 gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right \"['<Super>Right']\""

    run_command "Set move window to workspace (Shift+Super+Left/Right)" \
        bash -c "gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left \"['<Shift><Super>Left']\" && \
                 gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right \"['<Shift><Super>Right']\""

    run_command "Set move window to first/last workspace" \
        bash -c "gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-1 \"['<Super><Shift>Home']\" && \
                 gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-last \"['<Super><Shift>End']\""

    run_command "Set switch to last workspace" \
        gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-last "['<Shift><Super>l']"

    run_command "Set workspace up/down navigation (Ctrl+Super+Up/Down/j/k)" \
        bash -c "gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up \"['<Primary><Super>Up', '<Primary><Super>KP_Up', '<Primary><Super>k']\" && \
                 gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down \"['<Primary><Super>Down', '<Primary><Super>KP_Down', '<Primary><Super>j']\""
}

configure_shell_keybindings() {
    log_info "Configuring GNOME Shell keybindings"

    run_command "Set Super+A for application view" \
        gsettings set org.gnome.shell.keybindings toggle-application-view "['<Super>a']"

    run_command "Set Super+S for quick settings" \
        gsettings set org.gnome.shell.keybindings toggle-quick-settings "['<Super>s']"

    run_command "Set Super+V for message tray" \
        gsettings set org.gnome.shell.keybindings toggle-message-tray "['<Super>v']"

    run_command "Set Super+N for notifications" \
        gsettings set org.gnome.shell.keybindings focus-active-notification "['<Super>n']"

    run_command "Set screenshot keybindings" \
        bash -c "gsettings set org.gnome.shell.keybindings screenshot \"['<Shift>Print']\" && \
                 gsettings set org.gnome.shell.keybindings screenshot-window \"['<Alt>Print']\" && \
                 gsettings set org.gnome.shell.keybindings show-screenshot-ui \"['<Shift><Control>5']\""
}

configure_gnome_keyboard() {
    log_info "Configuring GNOME keyboard shortcuts and mappings"

    if ! command -v gsettings &>/dev/null; then
        log_error "gsettings not found, skipping GNOME keyboard configuration"
        return 1
    fi

    backup_keyboard_config

    configure_xkb_options
    configure_input_sources
    configure_custom_keybindings
    configure_wm_keybindings
    configure_shell_keybindings

    log_success "GNOME keyboard configuration completed"
}
