#!/bin/bash


function import_dir_history()
{
    if test ! -e ~/system_config/.cache/.bash_history_bak; then
        touch ~/system_config/.cache/.bash_history_bak
    fi

    tail -n 50 ~/.bash_history | head -n 49 | while read line; do
        local dup_str=`escape_all_regex_char "$line"`
        sed -i "/^${dup_str}$/d" ~/system_config/.cache/.bash_history_bak
        if test $? -eq 0; then
            echo "$line" >> ~/system_config/.cache/.bash_history_bak
        fi
    done
}


function re_select_output_line()
{
    echo -e "=> \c"
    local select_number
    read select_number

    select_output_line "$select_number"
    local select_output_line_ret="$?"

    if [[ $select_output_line_ret -ge 0 && $select_output_line_ret -lt ${#output_line_array[@]} ]]; then
        echo -e "${output_line_array[$select_number]}\c" | xclip -selection clipboard
    elif [[ $select_output_line_ret -eq ${#output_line_array[@]} ]]; then
        choose_to_display_or_not
        if [[ $? -eq 0 ]]; then
            display_output_line_array
        else
            return 1
        fi
        re_select_output_line
    else
        echo 're: please check your input'
    fi
}


cmd_para_num="$#"
output_line_array=()

if [ $cmd_para_num -eq 0 ]; then
    return 0
else
    i=0
    while read line; do
        line=${line// /%#}
        match_line $@ "$line"
        if [ $? -eq 0 ]; then
            line=${line//%#/ }
            is_existed_in_array "$line"
            if [[ "$?" -ne 0 ]]; then
                output_line_array[$i]=$line
                let i++
            fi
        fi
    done < ~/.bash_history

    reverse_output_array

    if test ! $? -eq 0; then
        return 0
    fi
fi

if [[ ${#output_line_array[@]} -eq 0 ]]; then
    echo 're: found no history'
    return 0
fi

choose_to_display_or_not
if [[ $? -eq 0 ]]; then
    display_output_line_array
else
    return 1
fi
re_select_output_line
