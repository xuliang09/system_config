#!/bin/bash


while read line
do
	dup_str=${line//\//\\\/}
	sed -i "/^${dup_str}$/d" ~/system_config/.bash_history_bak &>/dev/null
	echo $line >> ~/system_config/.bash_history_bak
done < ~/.bash_history
