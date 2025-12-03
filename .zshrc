export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=""

fpath+=($HOME/.zsh/pure)
plugins=(git vi-mode history-substring-search)

autoload -U promptinit; promptinit
prompt pure

source $ZSH/oh-my-zsh.sh
source /usr/share/nvm/init-nvm.sh

export PATH=~/.npm-global/bin:$PATH

# Android
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

alias vi=nvim
alias vim=nvim
alias st="source ~/.profile"
alias feh="imv"
