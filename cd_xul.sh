#!/bin/bash


function save_dir_history() {
    if test ! -e ~/system_config/.cache/.dir_history
    then
        touch ~/system_config/.cache/.dir_history
    fi

    local dup_str=`escape_all_regex_char "$1"`
    sed -i "/^${dup_str}$/d" ~/system_config/.cache/.dir_history
    echo "$1" >> ~/system_config/.cache/.dir_history
}


function cd_select_output_line() {
    echo -e "=> \c"
    local select_number
    read select_number

    select_output_line "$select_number"
    local select_output_line_ret="$?"

    if [[ $select_output_line_ret -ge 0 && $select_output_line_ret -lt ${#output_line_array[@]} ]]; then
        builtin cd ${output_line_array[$select_output_line_ret]}
        save_dir_history `pwd`
    elif [[ $select_output_line_ret -eq ${#output_line_array[@]} ]]; then
        choose_to_display_or_not
        if [[ $? -eq 0 ]]; then
            display_output_line_array
        else
            return 1
        fi
        cd_select_output_line
    else
        echo 'cd_xul: please check your input'
    fi
}


output_line_array=()

if [ $# -eq 0 ]; then
    builtin cd ~
    return 0
elif [ $# -eq 1 ]; then
    if test -e $1; then
        builtin cd $1
        save_dir_history `pwd`
        return 0
    fi
fi

if test ! -e ~/system_config/.cache/.dir_history; then
    builtin cd $@
    return $?
fi

i=0
for line in `tac ~/system_config/.cache/.dir_history`; do
    match_line "$@" "$line"
    if [ $? -eq 0 ]; then
        output_line_array[$i]="$line"
        let i++
    fi
done

if test ${#output_line_array[@]} -eq 0; then
    builtin cd $@
    return $?
fi

choose_to_display_or_not
if [[ $? -eq 0 ]]; then
    display_output_line_array
else
    return 1
fi
cd_select_output_line
