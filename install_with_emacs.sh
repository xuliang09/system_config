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
    if test ! -e ~/.vimrc; then
        ln -s ~/system_config/.vimrc ~/.vimrc
        mkdir ~/.vim && mkdir ~/.vim.bundle
        git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    fi
}


function install_spacemacs() {
    if test ! -e ~/.emacs.d; then
        ln -s ~/system_config/.spacemacs ~/.spacemacs
        git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
    fi
}


function main() {
    dir=`pwd`

    bash_do

    # vim
    sudo apt install vim
    install_vimrc

    # emacs
    sudo apt install emacs
    install_spacemacs

    # software
    sudo apt install xclip -y
    sudo apt install nautilus -y

    # config spacemacs
    # python lib
    sudo apt install python-pip
    sudo pip install --upgrade pip
    sudo pip install flake8
    sudo pip install autoflake
    sudo pip install yapf
    # install pylookup
    builtin cd ~/.emacs.d/layers/+lang/python/local/pylookup/
    chmod +x pylookup.py
    sudo make download

    # cd back
    builtin cd $dir
}


main
