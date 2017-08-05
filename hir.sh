#!/bin/bash


while read line
do
	if test ! -e ~/system_config/.bash_history_bak; then
		touch ~/system_config/.bash_history_bak
	fi

	dup_str=${line//\//\\\/}
	sed -i "/^${dup_str}$/d" ~/system_config/.bash_history_bak
	if test $? -eq 0; then
		echo $line >> ~/system_config/.bash_history_bak
	fi
done < ~/.bash_history
