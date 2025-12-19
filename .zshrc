# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="/opt/homebrew/bin:$PATH"
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^[ ' autosuggest-accept

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

if [ -f ~/.zshrc_alias ];
    then . ~/.zshrc_alias;
fi

# history setup
HISTFILE=$HOME/.zhistory
HISTSIZE=10000
SAVEHIST=10000
HISTDUP=erase
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify
setopt hist_ignore_all_dups
setopt hist_save_no_dups

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

bindkey "^H" backward-delete-char
bindkey "^?" backward-delete-char
bindkey "^[[3~" delete-char


# ---- Eza (better ls) -----
alias ls="eza --icons=always"
alias grep='grep --color=auto'

source <(fzf --zsh)
eval "$(fnm env --use-on-cd --shell zsh)"

