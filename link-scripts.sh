#!/bin/bash
set -euo pipefail

SOURCE_DIR=$(pwd)/scripts
TARGET_DIR="$HOME/.local/bin"

# Arrays to track results
declare -a success_files=()
declare -a error_files=()

# Critical setup checks (these will exit on failure due to -e)
echo "Performing initial checks..."

if [[ ! -d "$SOURCE_DIR" ]]; then
    echo "ERROR: Source directory $SOURCE_DIR does not exist."
    exit 1
fi

if ! echo "$PATH" | grep -q "$HOME/.local/bin"; then
    echo "ERROR: $HOME/.local/bin is not in your PATH."
    echo "Add the following line to your ~/.zshrc (or ~/.bashrc):"
    echo '    export PATH="$HOME/.local/bin:$PATH"'
    echo "Then run: source ~/.zshrc"
    exit 1
fi

# Create target directory (critical operation)
mkdir -p "$TARGET_DIR"

echo "Linking scripts from $SOURCE_DIR to $TARGET_DIR..."

# Disable -e for the main processing loop
set +e

# Process each script file
for script in "$SOURCE_DIR"/*.sh; do
    # Skip if no .sh files exist
    [[ -e "$script" ]] || continue
    
    script_name=$(basename "$script")
    target_path="$TARGET_DIR/$script_name"
    
    # Attempt to create symlink with explicit error handling
    if ln -sf "$script" "$target_path" 2>/dev/null; then
        echo "Linked: $script_name"
        success_files+=("$script_name")
    else
        echo "ERROR: Failed to link $script_name"
        error_files+=("$script_name")
    fi
done

# Re-enable strict error handling for final checks
set -e

# Summary report
echo ""
echo "=== SUMMARY ==="
echo "Successfully linked: ${#success_files[@]} script(s)"
if [[ ${#success_files[@]} -gt 0 ]]; then
    printf "  - %s\n" "${success_files[@]}"
fi

if [[ ${#error_files[@]} -gt 0 ]]; then
    echo "Failed to link: ${#error_files[@]} script(s)"
    printf "  - %s\n" "${error_files[@]}"
    echo ""
    echo "WARNING: Some scripts failed to link. Check permissions and disk space."
    exit 1
else
    echo "All scripts linked successfully!"
fi

