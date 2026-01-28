# Migration Guide

## Changes from Old Script

### What Changed

**Old Structure** (353 lines in one file):
- All logic in `fedora.sh`
- Hardcoded package lists
- Functions mixed with execution

**New Structure** (572 lines across 8 files):
- Modular library files in `lib/`
- Declarative data files in `data/`
- Main orchestrator in `fedora.sh` (96 lines)

### File Mapping

| Old Location | New Location |
|-------------|--------------|
| `ulauncher_extensions.txt` | `data/ulauncher-extensions.txt` |
| Hardcoded in script | `data/dnf-packages.txt` |
| Hardcoded in script | `data/copr-packages.txt` |
| Hardcoded in script | `data/flatpak-apps.txt` |
| Hardcoded in script | `data/fonts.txt` |
| - | `config/settings.env` |

### How to Enable Commented-Out Packages

In the old script, many packages were commented out. To enable them:

1. **DNF Packages**: Uncomment lines in `data/dnf-packages.txt`
2. **Flatpak Apps**: Uncomment lines in `data/flatpak-apps.txt`
3. **COPR Packages**: Already active in `data/copr-packages.txt`

### New Capabilities

1. **Skip Sections**: Use `config/settings.env` to skip entire sections
   ```bash
   SKIP_HOMEBREW=true  # Skip Homebrew installation
   ```

2. **Easy Package Management**: Add/remove packages by editing text files
   ```bash
   echo "htop" >> data/dnf-packages.txt
   ```

3. **Reusable Libraries**: Source individual libraries in other scripts
   ```bash
   source lib/dnf.sh
   install_dnf_packages "my-custom-packages.txt"
   ```

4. **Multiple Font Downloads**: Fonts with same name will be grouped
   ```
   MyFont|ttf|https://example.com/regular.ttf
   MyFont|ttf|https://example.com/bold.ttf
   ```

### Testing the New Script

**Dry Run** (check syntax without executing):
```bash
bash -n fedora.sh
bash -n lib/*.sh
```

**Selective Testing** (skip system update):
```bash
echo "SKIP_SYSTEM_UPDATE=true" > config/settings.env
./fedora.sh
```

**Monitor Progress**:
```bash
tail -f /tmp/fedora-postinstall-*.log
```

### Reverting to Old Script

The old script was completely rewritten. If you want to keep it:

1. Check git history:
   ```bash
   git log fedora.sh
   git show <commit-hash>:fedora.sh > fedora-old.sh
   ```

2. Or create a backup before running:
   ```bash
   cp fedora.sh fedora-backup.sh
   ```

## Benefits of New Structure

1. **Maintainability**: Add packages by editing text files, not code
2. **Reusability**: Libraries can be used in other scripts
3. **Testability**: Test individual components in isolation
4. **Extensibility**: Add new package types easily
5. **Clarity**: Clear separation between data, logic, and configuration
