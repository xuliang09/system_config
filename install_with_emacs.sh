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


function install_vimrc() {
    mv ~/.vim ~/.vim_bak
    mv ~/.vimrc ~/.vimrc_bak
    mkdir ~/.vim && mkdir ~/.vim.bundle
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    mv ~/system_config/.vimrc ~/.vimrc
}


bash_do
install_vimrc

sudo apt install xclip -y
sudo apt install nautilus -y
