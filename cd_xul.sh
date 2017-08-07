#!/bin/bash

. ~/system_config/escape_all_regex_char.sh

save_dir_history()
{
	if test ! -e ~/system_config/.cache/.dir_history
	then
		touch ~/system_config/.cache/.dir_history
	fi

	# no dup
	dup_str=$1
	dup_str=`escape_all_regex_char "$dup_str"`
	sed -i "/^${dup_str}$/d" ~/system_config/.cache/.dir_history
	echo "$1" >> ~/system_config/.cache/.dir_history
}


match_line()
{
	#echo $@
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
		builtin cd ${output_line_array[$select_number]}
		save_dir_history `pwd`
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
			echo 'cd: found no path'
			return 0
		fi
		#set +x
		select_output_line
	elif [[ $select_number -ge $output_line_array_num ]]
	then
		echo 'input incorrect!'
	else
		echo 'select_output_line unexcepted case'
	fi
}


cmd_para_num="$#"
output_line_array=()

if [ $cmd_para_num -eq 0 ]
then
	builtin cd ~
	return 0
elif [ $cmd_para_num -eq 1 ]
then
	if test -e $1
	then
		builtin cd $1
		save_dir_history `pwd`
		return 0
	fi
fi

i=0

if test ! -e ~/system_config/.cache/.dir_history; then
	builtin cd $@
	return $?
fi

for line in `tac ~/system_config/.cache/.dir_history`
do
	match_line $@ $line
	if [ $? -eq 0 ]
	then
		# add to array, output it
		output_line_array[i]=$line
		echo $i\) $line
		let i++
	fi
done

if test ${#output_line_array[@]} -eq 0
then
	builtin cd $@
	return $?
fi

#set -x
select_output_line
#set +x

