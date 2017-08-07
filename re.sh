#!/bin/bash

# input paras
# read .bash_history_bak
# output all possible lines
# filter again or select one
# line to screen

. ~/system_config/escape_all_regex_char.sh

import_dir_history()
{
	if test ! -e ~/system_config/.bash_history_bak
	then
		touch ~/system_config/.bash_history_bak
	fi

	# no dup
	tail -n 50 ~/.bash_history | head -n 49 | while read line
	do
		dup_str=${line}
		dup_str=`escape_all_regex_char "$dup_str"`
		sed -i "/^${dup_str}$/d" ~/system_config/.bash_history_bak
		if test $? -eq 0; then
			echo "$line" >> ~/system_config/.bash_history_bak
		fi
	done
}


match_line()
{
	line=${!#}
	for para in $@
	do
		if [[ ! "$line" =~ "$para" ]]
		then
			return 1
		fi
	done
	return 0
}


isdigit()
{
	expr $1 + 1 &>/dev/null
	return $?
}


select_output_line()
{
	echo -e "=> \c"
	read select_number

	#set -x
	if [[ "$select_number" == '' ]]
	then
		select_number=0
	fi
	#set +x

	output_line_array_num=${#output_line_array[@]}
	isdigit $select_number
	isdigit_state=$?
	if [[ $isdigit_state -eq 0 && $select_number -lt $output_line_array_num ]]
	then
		echo -e "${output_line_array[$select_number]}\c" | xclip -selection clipboard
	elif [[ $isdigit_state -ne 0 ]]
	then
		temp_output_line_array=()
		output_line_array_size=${#output_line_array[@]}
		for((i=0;i<$output_line_array_size;i++));
		do
			line=${output_line_array[$i]}
			line=${line// /%#}
			match_line "$select_number" "$line"

			if [ $? -eq 0 ]; then
				line=${line//%#/ }
				temp_output_line_array[i]=$line
			fi
		done
		output_line_array=("${temp_output_line_array[@]}")
		if test ${#output_line_array[@]} -eq 0
		then
			echo 're: found no history'
			return 0
		fi
		choose_to_display_or_not
		select_output_line
	elif [[ $select_number -ge $output_line_array_num ]]
	then
		echo 're: input incorrect!'
	else
		echo 're: select_output_line unexcepted case'
	fi
}


display_all() {
	cnt=0
	for((i=$1-1;i>=0;i--)); do
		echo ${cnt}\) ${output_line_array[i]}
		let cnt++
	done
}


choose_to_display_or_not() {
	if test ${#output_line_array[@]} -gt 20; then
		echo -e "total found: ${#output_line_array[@]}, display all? (y/N) \c"
		read select_op
		if [[ $select_op == '' || $select_op == 'n' || $select_op == 'N' ]]; then
			return 1
		elif [[ $select_op == 'y' || $select_op == 'Y' ]]; then
			display_all ${#output_line_array[@]}
		else
			echo 're: input incorrect'
		fi
	else
		display_all ${#output_line_array[@]}
	fi
	return 0
}


cmd_para_num="$#"
output_line_array=()

if [ $cmd_para_num -eq 0 ]; then
	return 0
else
	import_dir_history
	i=0
	while read line
	do
		line=${line// /%#}
		match_line $@ "$line"
		if [ $? -eq 0 ]
		then
			line=${line//%#/ }
			output_line_array[i]=$line
			let i++
		fi
	done < ~/system_config/.bash_history_bak

	choose_to_display_or_not
	if test ! $? -eq 0; then
		return 0
	fi
fi

if test ${#output_line_array[@]} -eq 0
then
	echo 're: found no history'
	return 0
fi

select_output_line
