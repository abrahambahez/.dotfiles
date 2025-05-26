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

# Depends on npm i -g semantic-git-commit-cli
alias gc=sgc

# Python
alias py="python3"

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

notes_base_dir="/Users/sabhz/archivo/idearium/notas/"

alias nt="cd $notes_base_dir"

function nn () {
    # Search or create
    cd $notes_base_dir;
    zk edit --interactive
}

function ntg () {
    # Edit notes with inbox tag
    cd $notes_base_dir;
    zk edit --tag "$1" --interactive
}

function nd () {
    cd $notes_base_dir;
    zk new --group journal --no-input
}

function blog () {
    cd ~/Documents/dev/sabhz-web/src/content/blog/
    zk edit --interactive
}

# Linux Only 👇

if [[ "$(uname)" == "Linux" ]]; then
  alias open="xdg-open"
fi
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
