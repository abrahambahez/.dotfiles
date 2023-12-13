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

# Navigation
#
alias l="ls --color=auto"
alias ll="ls -la --color=auto"
## go to dir using fzf
function zdir () {
	cd $(find * -type d | fzf)
}

# Linux Only 👇
alias opn="xdg-open"

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
#
# Linux Only 👇
# Fedora: npm i libgen-downloader cli
alias lib="libgen-downloader"

# Todo.txt
alias t="todo.sh"
alias tconf="nvim ~/.todo.cfg"
alias tv="nvim /Users/sabhz/Library/Mobile Documents/com~apple~CloudDocs/Documentos/archivo/+/todo.txt"

# Karmapulse Notes

function kpnote () { cd ~/Documents/karmapulse/ && nvim "$1.md" }
function kps () { 
	nvim "$(find ~/Documents/karmapulse | fzf)"
}

