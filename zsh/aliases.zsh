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
function sd () {
	cd $(find * -type d | fzf)
}
alias opn="xdg-open"

# Kitty
#
alias icat="kitty +kitten icat"

# Miscelaneous
#
alias zshrc="nvim ~/.zshrc"
alias v="nvim"
alias icl="cd /Users/sabhz/Library/Mobile\ Documents/com~apple~CloudDocs" # macos only
# Fedora: npm i libgen-downloader cli
alias lib="libgen-downloader"

