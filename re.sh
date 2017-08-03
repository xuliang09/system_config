#!/bin/bash

# input paras
# read .bash_history_bak
# output all possible lines
# filter again or select one
# line to screen


import_dir_history()
{
	if test ! -e ~/system_config/.bash_history_bak
	then
		touch ~/system_config/.bash_history_bak
	fi

	# no dup
	tail -n 50 ~/.bash_history | while read line
	do
		dup_str=${line//\//\\\/}
		sed -i "/^${dup_str}$/d" ~/system_config/.bash_history_bak
		echo $line >> ~/system_config/.bash_history_bak
	done
}


match_line()
{
	line=${!#}
	for para in $@
	do
		if [[ ! $line =~ $para ]]
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
	if [[ $select_number == '' ]]
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
		#set -x
		temp_output_line_array=()
		i=0
		for line in ${output_line_array[@]}
		do
			match_line $select_number $line

			if [ $? -eq 0 ]
			then
				# add to array, output it
				temp_output_line_array[i]=$line
				echo $i\) $line
				let i++
			fi
		done
		output_line_array=("${temp_output_line_array[@]}")
		if test ${#output_line_array[@]} -eq 0
		then
			echo 're: found no history'
			return 0
		fi
		#set +x
		select_output_line
	elif [[ $select_number -ge $output_line_array_num ]]
	then
		echo 're: input incorrect!'
	else
		echo 're: select_output_line unexcepted case'
	fi
}


cmd_para_num="$#"
output_line_array=()
i=0

if [ $cmd_para_num -eq 0 ]
then
	#str=`history 1`
	#substr=';'
	#substr_i=`echo "$str $str1" | awk '{print index($1, $2)}'`
	#if test $substr_i -eq 0
	#then
		#return 0
	#fi
	#save_dir_history ${str:substr_i:${#str}}
	return 0
else
	import_dir_history
	while read line
	do
		#set -x
		line=${line// /.}
		match_line $@ $line
		if [ $? -eq 0 ]
		then
			# add to array, output it
			line=${line//./ }
			output_line_array[i]=$line
			echo $i\) $line
			let i++
		fi
		#set +x
	done < ~/system_config/.bash_history_bak
fi
if test ${#output_line_array[@]} -eq 0
then
	echo 're: found no history'
	return 0
fi
#set -x
select_output_line
#set +x
