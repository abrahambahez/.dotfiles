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
function zo () {
  local file
  file=$(find . -type f 2>/dev/null | fzf) || return
  xdg-open "$file" >/dev/null 2>&1 &
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
  alias icedrive="IcedriveCLI-v3.33"
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

function mdcat(){ mdcat.sh -i "$1" }

# ALIASES WITH DEPENDENCIES
#
# Depends on npm i -g semantic-git-commit-cli
alias gc=sgc

# Depends on install https://github.com/abrahambahez/gliik
GLIIK_PATH="~/Documentos/dev/gliik/gliik"
alias gl="$GLIIK_PATH"
function glls() {
  "$GLIIK_PATH" list | grep "$1"
}

# Trani Aliases
# Depends on https://github.com/abrahambahez/trani
alias trani="~/Documentos/dev/trani/trani"

# Depends on pip install jrnl
alias j="jrnl"

# Depends on klog bin
alias log="klog track"

# Fedora: npm i libgen-downloader cli
alias lib="libgen-downloader"

# Restart espanso
alias respanso="espanso stop && espanso start"

# ZK Aliases
# dependent on `brew install zk`
alias zn="zk edit --interactive"
function zt() { zk edit --tag "$1" --interactive}
alias zd="zk new --group journal --no-input"

