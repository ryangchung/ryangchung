if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git brew zoxide)
source $ZSH/oh-my-zsh.sh

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias vi=nvim
alias vim=nvim
alias cd="z"
alias find="fzf"
alias lsa="ls -1a"
alias ccat="highlight -O ansi --force"
alias sudo-nix-build="~/ryangchung/install.sh"

export ZSH="$HOME/.oh-my-zsh"
export EDITOR=nvim
export PATH="$HOME/.local/bin:$PATH"

bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
bindkey "^[[1;9C" end-of-line
bindkey "^[[1;9D" beginning-of-line
