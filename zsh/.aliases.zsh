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
function zd () {
    cd $(find * -type d | fzf)
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

