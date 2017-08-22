#!/bin/bash


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


function main() {
    local cmd_para_num="$#"
    output_line_array=()

    if [ $cmd_para_num -eq 0 ]; then
        return 0
    else
        local i=0
        local line
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
}


main $@
