#!/bin/bash

# support bash and zsh
# bash:1 zsh:2
function check_current_sh() {
    cur_sh=$SHELL
    if [[ $cur_sh == '/bin/bash' ]]; then
        return 1
    elif [[ $cur_sh == '/bin/zsh' ]]; then
        return 2
    else
        return 0
    fi
}


function bash_do() {
    if test ! -e ~/.bashrc; then
        touch ~/.bashrc
    fi

    grep '\. ~/system_config/\.bashrc' ~/.bashrc &>/dev/null
    if test $? -ne 0; then
        echo '. ~/system_config/.bashrc' >> ~/.bashrc
        . ~/.bashrc
    fi
}


function zsh_do() {
    if test ! -e ~/.zshrc; then
        touch ~/.zshrc
    fi

    grep '\. ~/system_config/\.bashrc' ~/.zshrc &>/dev/null
    if test $? -ne 0; then
        echo '. ~/system_config/.bashrc' >> ~/.zshrc
        . ~/.zshrc
    fi
}


check_current_sh
state="$?"
if [[ $state -eq 1 ]]; then
    bash_do
elif [[ $state -eq 2 ]]; then
    zsh_do
else
    echo 'install.sh: unsupported shell'
fi

sudo apt install xclip -y
sudo apt install nautilus -y
