# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export EDITOR=nvim
export LANG="es_ES.UTF-8"
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

