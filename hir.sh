#!/bin/bash

. escape_all_regex_char.sh

if test ! -e ~/system_config/.bash_history_bak; then
	touch ~/system_config/.bash_history_bak
fi

prev_num=`wc -l < ~/system_config/.bash_history_bak`

while read line
do
	dup_str=${line//\//\\\/}
	dup_str=`escape_all_regex_char "$dup_str"`
	sed -i "/^${dup_str}$/d" ~/system_config/.bash_history_bak
	if test $? -eq 0; then
		echo $line >> ~/system_config/.bash_history_bak
	fi
done < ~/.bash_history

cur_num=`wc -l < ~/system_config/.bash_history_bak`
import_num="`expr $cur_num - $prev_num`"
echo "hir: total import $import_num histories"
