#!/bin/bash

# mdcat - Extract content from markdown headers
# Usage: mdcat [-r] <file> <header>

show_usage() {
    echo "Usage: $0 [-r] [-i] <file> [header]"
    echo "  -r    Include subheadings recursively"
    echo "  -i    Interactive mode - select header using fzf"
    echo "  file  Markdown file to read"
    echo "  header Header name to extract (without # symbols)"
    echo ""
    echo "Examples:"
    echo "  $0 README.md 'Installation'"
    echo "  $0 -r docs.md 'API Reference'"
    echo "  $0 -i README.md"
    echo "  $0 -ri README.md"
}

# Parse command line options
recursive=false
interactive=false
while getopts "rih" opt; do
    case $opt in
        r)
            recursive=true
            ;;
        i)
            interactive=true
            ;;
        h)
            show_usage
            exit 0
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            show_usage
            exit 1
            ;;
    esac
done

shift $((OPTIND-1))

# Check if fzf is available when interactive mode is requested
if [ "$interactive" = true ] && ! command -v fzf &> /dev/null; then
    echo "Error: fzf is required for interactive mode but not found" >&2
    echo "Please install fzf: https://github.com/junegunn/fzf" >&2
    exit 1
fi

# Check arguments
if [ "$interactive" = true ]; then
    if [ $# -ne 1 ]; then
        echo "Error: Interactive mode requires exactly one argument (file)" >&2
        show_usage
        exit 1
    fi
    file="$1"
else
    if [ $# -ne 2 ]; then
        echo "Error: Wrong number of arguments" >&2
        show_usage
        exit 1
    fi
    file="$1"
    target_header="$2"
fi

# Check if file exists
if [ ! -f "$file" ]; then
    echo "Error: File '$file' not found" >&2
    exit 1
fi

# Interactive header selection
select_header() {
    local headers
    headers=$(grep "^#" "$file" 2>/dev/null)
    
    if [ -z "$headers" ]; then
        echo "Error: No headers found in $file" >&2
        exit 1
    fi
    
    # Present headers with fzf, showing both the original format and clean text
    local selected
    selected=$(echo "$headers" | fzf \
        --prompt="Select header: " \
        --height=~50% \
        --layout=reverse \
        --border \
        --preview="echo 'Preview:'; echo '{}'" \
        --preview-window=down:3:wrap)
    
    if [ -z "$selected" ]; then
        echo "No header selected" >&2
        exit 1
    fi
    
    # Extract clean header text (remove # symbols and trim whitespace)
    echo "$selected" | sed 's/^#*[[:space:]]*//' | sed 's/[[:space:]]*$//'
}

# Set target header based on mode
if [ "$interactive" = true ]; then
    target_header=$(select_header)
fi

# Function to get header level (count of # symbols)
get_header_level() {
    local line="$1"
    echo "$line" | grep -o '^#*' | wc -c
}

# Function to extract header text (remove # symbols and trim whitespace)
get_header_text() {
    local line="$1"
    echo "$line" | sed 's/^#*[[:space:]]*//' | sed 's/[[:space:]]*$//'
}

# Find the target header and extract content
extract_content() {
    local found_header=false
    local target_level=0
    local line_num=0
    
    while IFS= read -r line; do
        line_num=$((line_num + 1))
        
        # Check if this is a header line
        if [[ "$line" =~ ^#{1,6}[[:space:]] ]]; then
            local current_header_text=$(get_header_text "$line")
            local current_level=$(get_header_level "$line")
            
            if [ "$found_header" = false ]; then
                # Looking for our target header
                if [ "$current_header_text" = "$target_header" ]; then
                    found_header=true
                    target_level=$current_level
                    echo "$line"  # Print the header itself
                fi
            else
                # We're inside our target section
                if [ $current_level -le $target_level ]; then
                    # Found a header at same or higher level - end of section
                    break
                elif [ "$recursive" = true ] || [ $current_level -eq $((target_level + 1)) ]; then
                    # Print subheader if recursive or immediate child
                    if [ "$recursive" = true ]; then
                        echo "$line"
                    elif [ $current_level -eq $((target_level + 1)) ]; then
                        echo "$line"
                    fi
                fi
            fi
        elif [ "$found_header" = true ]; then
            # We're inside our target section - print content
            echo "$line"
        fi
    done < "$file"
    
    if [ "$found_header" = false ]; then
        echo "Error: Header '$target_header' not found in $file" >&2
        exit 1
    fi
}

# Execute the extraction
extract_content
