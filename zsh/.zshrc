# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# source antidote
source ${ZDOTDIR:-~}/.antidote/antidote.zsh

# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load

# Move antidote cache
export ANTIDOTE_HOME=~/.cache/antidote

# --------------
### MORE CONFIG
# --------------
export EDITOR=nvim
export LANG="es_ES.UTF-8"
export PATH="$HOME/.local/bin:$PATH" # Add local path for scripts
autoload zmv
bindkey -v # use vi key bindings 
bindkey -v '^?' backward-delete-char # avoid the annoying backspace/delete issue

# aliases
source ~/.aliases.zsh
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# sourcing some env
source ~/.profile
# . "$HOME/.local/bin/env"

if [[ "$(uname)" == "Linux" ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi


# opencode
export PATH=/home/sabhz/.opencode/bin:$PATH

. "$HOME/.cargo/env"
