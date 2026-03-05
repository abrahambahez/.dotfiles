alias rm="rm -i"

# Git
#
alias gs="git status"
alias gaa="git add ."
alias gp="git pull"
alias gps="git push -u origin main"
alias gb="git branch"
function gcl () { git clone "$1" }
#function gc () { git commit -m "$1" }
function gca () { git add -A && git commit -m "$1" }
alias kpclone="~/.dotfiles/scripts/clonekp.sh"

# Python
alias py="python3"

# Navigation
#
alias l="ls --color=auto"
alias ll="ls -la --color=auto"

## go to dir using fzf
function zcd () {
    cd $(find * -type d | fzf)
}

# open file using fzf
function zof () {
  local file
  file=$(find . -type f 2>/dev/null | fzf) || return
  xdg-open "$file" >/dev/null 2>&1 &
}

function zv() {
  local file
  file=$(find . -type f 2>/dev/null | fzf) || return
  nvim "$file" >/dev/null 2>&1 &
}

# Open configs
alias vconf="nvim ~/.config/nvim/init.lua"
alias zshrc="nvim ~/.zshrc"

# Miscelaneous
#
alias vi="nvim ."
alias v="nvim"

# OS Specific Logic 👇

if [[ "$(uname)" == "Linux" ]]; then
  alias open="xdg-open"
  alias icedrive="IcedriveCLI-v3.57"
  alias copy="wl-copy"
  alias paste="wl-paste"
  BLOGDIR="~/Archivo/dev/sabhz-web/src/content/blog/"
  alias clean="sudo ~/.local/bin/fedorable.sh"
elif [[ "$(uname)" == "Darwin" ]]; then
  alias copy="pbcopy"
  alias paste="pbpaste"
  BLOGDIR="$HOME/Archivo/dev/sabhz-web/src/content/blog/"
  alias icl="cd /Users/sabhz/Library/Mobile\ Documents/com~apple~CloudDocs" # macos only
fi

alias blog="cd $BLOGDIR"

alias prj="cd ~/archivo/projects/ && nvim ."
function mdcat(){ mdcat.sh -i "$1" }

# ALIASES WITH DEPENDENCIES
#
# Depends on npm i -g semantic-git-commit-cli
alias gc=sgc

# Search citekey
# Depends on bibtool
bibs() {
    local bib_file="$OBSIDIAN_MAIN_VAULT"librero.bib

    local selected=$(grep -E "^@" "$bib_file" | \
        sed -E 's/^@[^{]+\{(.+),/\1/' | \
        fzf --header "Buscar en $bib_file" --prompt "Bib> " --preview "bibtool -X {1} $bib_file")

    [ -n "$selected" ] && bibtool -X "$selected" "$bib_file"
}


refs() {
    local bib_file="$OBSIDIAN_MAIN_VAULT"brrd/inbox/refs.bib

    local selected=$(grep -E "^@" "$bib_file" | \
        sed -E 's/^@[^{]+\{(.+),/\1/' | \
        fzf --header "Buscar en $bib_file" --prompt "Bib> " --preview "bibtool -X {1} $bib_file")

    [ -n "$selected" ] && bibtool -X "$selected" "$bib_file"
}

# Trani Aliases
# Depends on https://github.com/abrahambahez/trani
TRANI_PATH="~/Documentos/dev/trani/trani"
alias trani="$TRANI_PATH"
# Alias for testing
function trn() {
  $TRANI_PATH start "$1" --preserve-audio
}

function session() {
  cd ~/archivo/sessions/
  local file
  file=$(find . -type f 2>/dev/null | fzf) || return
  nvim "$file" >/dev/null 2>&1 &
}

# Depends on pip install jrnl
alias j="jrnl"

# Depends on klog bin
alias log="klog track"

# Fedora: npm i libgen-downloader cli
alias lib="libgen-downloader"

# Restart espanso
alias respanso="espanso stop && espanso start"

