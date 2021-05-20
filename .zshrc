# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/winter/.oh-my-zsh"

# PURE_PROMPT_SYMBOL="λ >"

fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure

ZSH_THEME=""
plugins=(git vi-mode history-substring-search)

source /usr/share/nvm/init-nvm.sh

source $ZSH/oh-my-zsh.sh
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

alias fontviewer="gucharmap"
alias music=ncmpcpp
alias cpuinfo="cat /proc/cpuinfo | grep MHz"
alias powerset-ps="sudo cpupower frequency-set -g powersave"
alias powerset-p="sudo cpupower frequency-set -g performance"
alias powerset-c="sudo cpupower frequency-set -g conservative"
alias powerset-u="sudo cpupower frequency-set -f 2.8GHz"
alias nvimrc="nvim ~/.config/nvim/init.vim"
alias i3rc="nvim ~/.config/i3/config"
alias polyrc="nvim ~/.config/polybar/config"
alias vim="nvim"
alias vimrc="nvim ~/.config/nvim/init.vim"
alias ghci="ghci +RTS -K2M -RTS"
alias rc="roficlip"

[ "$XDG_CURRENT_DESKTOP" = "KDE" ] || [ "$XDG_CURRENT_DESKTOP" = "GNOME" ] || export QT_QPA_PLATFORMTHEME="qt5ct"

export TERM="xterm-256color"

export PATH=~/.local/bin:$PATH
export PATH=~/.scripts:$PATH
[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"
[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"
