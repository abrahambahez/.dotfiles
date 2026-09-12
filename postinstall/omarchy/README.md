# Omarchy Post-Install Script

Modular, error-tolerant Omarchy (Arch Linux + Hyprland) post-installation automation, mirroring the structure of `postinstall/linux/` (Fedora).

## Structure

```
omarchy/
├── omarchy.sh                  # Main orchestrator script
├── lib/                        # Reusable function libraries
│   ├── core.sh                 # Logging, error handling, core utilities
│   ├── pacman.sh                # Pacman package management
│   ├── aur.sh                    # AUR package management (via yay/paru)
│   ├── fonts.sh                  # Font installation
│   └── extras.sh                 # Additional tools (zsh, UV)
├── data/                        # Declarative package lists
│   ├── pacman-packages.txt      # Official repo packages (one per line)
│   ├── aur-packages.txt          # AUR package names (one per line)
│   └── fonts.txt                  # Font definitions (name|type|url)
└── config/
    └── settings.env             # Optional configuration overrides
```

## Usage

```bash
./omarchy.sh
```

Requires an AUR helper (`yay` or `paru`) already installed before running, since `install_aur_packages` will not install one for you.

### Customizing Installations

Edit the text files in `data/` to control what gets installed:

**Pacman packages** (`data/pacman-packages.txt`):
```
zsh
neovim
ghostty
```

**AUR packages** (`data/aur-packages.txt`):
```
spotify
zen-browser-bin
```

**Fonts** (`data/fonts.txt`):
```
Hack|zip|https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.0/Hack.zip
MyFont|ttf|https://example.com/font.ttf
```

### Configuration Options

Edit `config/settings.env`:

```bash
SKIP_SYSTEM_UPDATE=false
SKIP_ZSH_SETUP=false
SKIP_UV_PYTHON=false
AUTO_LOGOUT=true
```

## What is intentionally different from the Fedora script

- No Flatpak/Flathub: every app that used to come from Flathub has a native pacman or AUR package (see `data/aur-packages.txt` and `data/pacman-packages.txt`).
- No Homebrew.
- No GNOME keyboard configuration (`gsettings`/`dconf`). Hyprland keybindings are declarative config files, not something this script can safely generate without having seen the real config Omarchy creates on install. Layer your keybinding overrides manually in `~/.config/hypr/` after installing.
- No Ulauncher extensions installer. Omarchy's default launcher is `walker`, which doesn't use Ulauncher's extension format.
- `logout_session` calls `hyprctl dispatch exit` instead of `gnome-session-quit`.

## Known follow-ups

- The `clean` alias in `zsh/.aliases.zsh` still points to `scripts/fedorable.sh` (DNF/RPM/GRUB only). It is intentionally left untouched since that file is shared with the still-active Fedora setup; update or remove that alias once Omarchy is the only OS in use.
- Confirm whether Omarchy ships `yay` or `paru` out of the box; if not, install one before running `./omarchy.sh`.

## Troubleshooting

```bash
tail -f /tmp/omarchy-postinstall-*.log
grep ERROR /tmp/omarchy-postinstall-*.log
```

## License

MIT
