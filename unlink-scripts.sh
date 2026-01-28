#!/bin/bash
set -euo pipefail

SOURCE_DIR=$(pwd)/scripts
TARGET_DIR="$HOME/.local/bin"

# Arrays to track results
declare -a unlinked_files=()
declare -a not_found_files=()
declare -a not_symlink_files=()
declare -a error_files=()

# Critical setup checks (these will exit on failure due to -e)
echo "Performing initial checks..."

if [[ ! -d "$TARGET_DIR" ]]; then
    echo "ERROR: Target directory $TARGET_DIR does not exist."
    exit 1
fi

if [[ ! -d "$SOURCE_DIR" ]]; then
    echo "WARNING: Source directory $SOURCE_DIR does not exist."
    echo "Will attempt to unlink any symlinks pointing to this path anyway."
fi

echo "Unlinking scripts from $TARGET_DIR..."

# Disable -e for the main processing loop
set +e

# Process each potential script file
for script in "$SOURCE_DIR"/*.sh; do
    # Get the script name even if source doesn't exist
    script_name=$(basename "$script")
    target_path="$TARGET_DIR/$script_name"
    
    # Check if target file exists
    if [[ ! -e "$target_path" ]]; then
        not_found_files+=("$script_name")
        continue
    fi
    
    # Check if it's a symlink
    if [[ ! -L "$target_path" ]]; then
        echo "WARNING: $script_name exists but is not a symlink. Skipping."
        not_symlink_files+=("$script_name")
        continue
    fi
    
    # Get the symlink target
    link_target=$(readlink "$target_path" 2>/dev/null)
    
    # Check if it points to our source (handle both single and double slash cases)
    if [[ "$link_target" == "$script" ]] || [[ "$link_target" == "$SOURCE_DIR/$script_name" ]] || [[ "$link_target" == "$SOURCE_DIR//$script_name" ]]; then
        # Attempt to remove the symlink
        if rm "$target_path" 2>/dev/null; then
            echo "Unlinked: $script_name"
            unlinked_files+=("$script_name")
        else
            echo "ERROR: Failed to unlink $script_name"
            error_files+=("$script_name")
        fi
    else
        echo "INFO: $script_name points to different location ($link_target). Skipping."
        not_found_files+=("$script_name")
    fi
done

# Also check for any other symlinks in TARGET_DIR that point to SOURCE_DIR
# This catches cases where files might have been renamed or we missed something
echo ""
echo "Checking for other symlinks pointing to $SOURCE_DIR..."

for target_file in "$TARGET_DIR"/*; do
    [[ -e "$target_file" ]] || continue
    
    if [[ -L "$target_file" ]]; then
        link_target=$(readlink "$target_file" 2>/dev/null)
        file_name=$(basename "$target_file")
        
        # Skip if we already processed this file
        if printf '%s\n' "${unlinked_files[@]}" "${not_found_files[@]}" "${not_symlink_files[@]}" "${error_files[@]}" | grep -Fxq "$file_name"; then
            continue
        fi
        
        # Check if it points to our source directory (any pattern)
        if [[ "$link_target" == "$SOURCE_DIR"* ]]; then
            if rm "$target_file" 2>/dev/null; then
                echo "Unlinked additional: $file_name"
                unlinked_files+=("$file_name")
            else
                echo "ERROR: Failed to unlink additional $file_name"
                error_files+=("$file_name")
            fi
        fi
    fi
done

# Re-enable strict error handling for final checks
set -e

# Summary report
echo ""
echo "=== SUMMARY ==="
echo "Successfully unlinked: ${#unlinked_files[@]} script(s)"
if [[ ${#unlinked_files[@]} -gt 0 ]]; then
    printf "  - %s\n" "${unlinked_files[@]}"
fi

if [[ ${#not_found_files[@]} -gt 0 ]]; then
    echo "Not found or different target: ${#not_found_files[@]} script(s)"
    printf "  - %s\n" "${not_found_files[@]}"
fi

if [[ ${#not_symlink_files[@]} -gt 0 ]]; then
    echo "Exist but not symlinks: ${#not_symlink_files[@]} script(s)"
    printf "  - %s\n" "${not_symlink_files[@]}"
fi

if [[ ${#error_files[@]} -gt 0 ]]; then
    echo "Failed to unlink: ${#error_files[@]} script(s)"
    printf "  - %s\n" "${error_files[@]}"
    echo ""
    echo "WARNING: Some scripts failed to unlink. Check permissions."
    exit 1
else
    if [[ ${#unlinked_files[@]} -eq 0 ]]; then
        echo "No symlinks found to unlink."
    else
        echo "All targeted symlinks unlinked successfully!"
    fi
fi

