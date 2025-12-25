export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=""

fpath+=($HOME/.zsh/pure)
plugins=(git vi-mode history-substring-search)

autoload -U promptinit; promptinit
prompt pure

source $ZSH/oh-my-zsh.sh
source /usr/share/nvm/init-nvm.sh

export PATH=~/.npm-global/bin:$PATH

alias vi=nvim
alias vim=nvim
alias st="source ~/.profile"
alias feh="imv"
export PATH="$HOME/.local/bin:$PATH"

export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin

export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
export PATH=$PATH:$JAVA_HOME/bin

export PATH=$PATH:$HOME/.scripts

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /home/winter/.dart-cli-completion/zsh-config.zsh ]] && . /home/winter/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]




# Java UI fix in sway
export _JAVA_AWT_WM_NONREPARENTING=1
