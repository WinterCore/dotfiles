export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=""

plugins=(git vi-mode history-substring-search)

fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure

source $ZSH/oh-my-zsh.sh

alias vi=nvim
alias vim=nvim
alias cpuc="sudo cpupower frequency-set -g conservative"
alias cpus="sudo cpupower frequency-set -g schedutil"
alias cpup="sudo cpupower frequency-set -g performance"
alias cpups="sudo cpupower frequency-set -g powersave"
alias cpuinfo="cat /proc/cpuinfo | grep MHz"
alias fixkeyboard="setxkbmap -option compose:ralt && xset r rate 300 40"
alias nosleep="xset s off -dpms"

function fixmouse {
    device_id=$(xinput list | grep "Logitech G305.*pointer" | grep -o "id=[0-9]\+" | grep -o "[0-9]\+")
    xinput set-prop "$device_id" "libinput Accel Speed" -0.35
}

source /usr/share/nvm/init-nvm.sh
