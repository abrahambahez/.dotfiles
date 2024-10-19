# Git
#
alias gs="git status"
alias gaa="git add ."
alias gp="git pull"
alias gps="git push -u origin main"
alias gb="git branch"
function gcl () { git clone "$1" }
function gc () { git commit -m "$1" }
function gca () { git add -A && git commit -m "$1" }
alias kpclone="~/.dotfiles/scripts/clonekp.sh"

# Navigation
#
alias l="ls --color=auto"
alias ll="ls -la --color=auto"
## go to dir using fzf
function zdir () {
    cd $(find * -type d | fzf)
}

# Kitty
#
alias icat="kitty +kitten icat"
alias theme="kitty +kitten themes"

# Open configs
alias vconf="nvim ~/.config/nvim/init.lua"
alias zshrc="nvim ~/.zshrc"

# Miscelaneous
#
alias v="nvim"
alias icl="cd /Users/sabhz/Library/Mobile\ Documents/com~apple~CloudDocs" # macos only

# ZK Aliases
# dependent on `brew install zk`

notes_base_dir="/Users/sabhz/archivo/docs"
function nt () {
    cd $notes_base_dir;
    zk edit --interactive
}

function ni () {
    cd $notes_base_dir;
    zk edit --tag "inbox" --interactive
}

# Linux Only 👇

alias opn="xdg-open"

# ALIASES WITH DEPENDENCIES
#
# Fedora: npm i libgen-downloader cli
alias lib="libgen-downloader"

# Todo.txt
alias t="todo.sh"
alias tconf="nvim ~/.todo.cfg"
alias tv="nvim ~/archivo/docs/todo.txt"

# chatgpt cli from https://github.com/0xacx/chatGPT-shell-cli
alias chat="chatgpt -i $1"
alias gpt="chatgpt -p $1"
