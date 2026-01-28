# Fedora Post-Install Script

Modular, error-tolerant Fedora post-installation automation following Unix philosophy.

## Structure

```
linux/
├── fedora.sh                    # Main orchestrator script
├── lib/                         # Reusable function libraries
│   ├── core.sh                  # Logging, error handling, core utilities
│   ├── dnf.sh                   # DNF package management
│   ├── copr.sh                  # COPR repository management
│   ├── flatpak.sh              # Flatpak application management
│   ├── fonts.sh                # Font installation
│   ├── git-extensions.sh       # Git-based extensions installer
│   └── extras.sh               # Additional tools (zsh, UV, Homebrew, GNOME)
├── data/                        # Declarative package lists
│   ├── dnf-packages.txt        # DNF packages (one per line)
│   ├── copr-packages.txt       # COPR repos and packages (repo|package)
│   ├── flatpak-apps.txt        # Flatpak application IDs
│   ├── fonts.txt               # Font definitions (name|type|url)
│   └── ulauncher-extensions.txt # Git repository URLs
└── config/
    └── settings.env            # Optional configuration overrides
```

## Usage

### Basic Usage

```bash
./fedora.sh
```

### Customizing Installations

Edit the text files in `data/` to control what gets installed:

**DNF Packages** (`data/dnf-packages.txt`):
```
zsh
neovim
git
```

**COPR Packages** (`data/copr-packages.txt`):
```
pgdev/ghostty|ghostty
eclipseo/espanso|espanso
```

**Flatpak Apps** (`data/flatpak-apps.txt`):
```
org.zotero.Zotero
com.spotify.Client
```

**Fonts** (`data/fonts.txt`):
```
Hack|zip|https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.0/Hack.zip
MyFont|ttf|https://example.com/font.ttf
```

**Ulauncher Extensions** (`data/ulauncher-extensions.txt`):
```
https://github.com/hillaryychan/ulauncher-fzf
https://github.com/vanguard478/ulauncher-zoxide
```

### Configuration Options

Edit `config/settings.env` to customize behavior:

```bash
SKIP_SYSTEM_UPDATE=false
SKIP_ZSH_SETUP=false
SKIP_UV_PYTHON=false
SKIP_HOMEBREW=false
SKIP_GNOME_CONFIG=false
AUTO_LOGOUT=true
ULAUNCHER_EXTENSIONS_DIR="$HOME/.local/share/ulauncher/extensions"
```

## Features

### Error Tolerance
- Script continues on failures
- Each operation is independent
- Clear logging of what succeeded and what failed

### Logging
- Timestamped log files: `/tmp/fedora-postinstall-YYYYMMDD-HHMMSS.log`
- Three log levels: INFO, SUCCESS, ERROR
- Detailed error information with exit codes
- Summary report at the end

### Smart Installation
- Checks if packages/apps already installed
- Skips unnecessary operations
- Validates prerequisites before attempting installation

### Modular Design
- Separate data from logic
- Reusable library functions
- Easy to extend with new package types

## Adding New Package Types

1. Create a new library file in `lib/` (e.g., `lib/snap.sh`)
2. Create a data file in `data/` (e.g., `data/snap-packages.txt`)
3. Source the library in `fedora.sh`
4. Call the installer function in `fedora.sh`

Example:

```bash
# In lib/snap.sh
install_snap_packages() {
    local snap_file="$1"
    # Implementation here
}

# In fedora.sh
source "$LIB_DIR/snap.sh"
...
if [[ -f "$DATA_DIR/snap-packages.txt" ]]; then
    install_snap_packages "$DATA_DIR/snap-packages.txt"
fi
```

## File Format Rules

- Lines starting with `#` are comments
- Empty lines are ignored
- Inline comments supported: `package # this is a comment`
- Whitespace is trimmed

## Troubleshooting

Check the log file for detailed error information:
```bash
tail -f /tmp/fedora-postinstall-*.log
```

Search for errors:
```bash
grep ERROR /tmp/fedora-postinstall-*.log
```

## License

MIT
