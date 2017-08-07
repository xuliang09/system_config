#!/bin/bash

if test ! -e ~/.bashrc; then
	touch ~/.bashrc
fi

grep '\. ~/system_config/\.bashrc' ~/.bashrc &>/dev/null
if test $? -ne 0; then
	echo '. ~/system_config/.bashrc' >> ~/.bashrc
	. ~/.bashrc
fi

sudo apt install xclip -y
sudo apt install nautilus -y
