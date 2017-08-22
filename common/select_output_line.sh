#!/bin/bash


declare -a output_line_array


# description: read user input, if input string then filter output_line_array
#     else if input integer then return the array index of selected line
# paras: para
# return: error-(-1) filtering-(size of output_line_array) selected-(index of output_line_array)
function select_output_line() {
    local select_output_line_para="$@"

    if [[ "$select_output_line_para" == '' ]]; then
        select_output_line_para=0
    fi

    local output_line_array_size=${#output_line_array[@]}
    isdigit $select_output_line_para
    local isdigit_state="$?"
    if [[ $isdigit_state -eq 0 && $select_output_line_para -lt $output_line_array_size ]]; then
        return $select_output_line_para
    elif [[ $isdigit_state -ne 0 ]]; then
        local temp_output_line_array=()
        local cnt=0
        local i
        for((i=0;i<$output_line_array_size;i++)); do
            local line=${output_line_array[$i]}
            line=${line// /%#}
            match_line $select_output_line_para "$line"

            if [ $? -eq 0 ]; then
                line=${line//%#/ }
                temp_output_line_array[$cnt]="$line"
                let cnt++
            fi
        done
        output_line_array=("${temp_output_line_array[@]}")

        if [[ ${#output_line_array[@]} -eq 0 ]]; then
            return -1
        elif [[ ${#output_line_array[@]} -eq 1 ]]; then
            return 0
        else
            return "${#output_line_array[@]}"
        fi
    elif [[ $select_output_line_para -ge $output_line_array_size ]]; then
        return -1
    fi
}


# description: display output_line_array
# paras:
# return:
function display_output_line_array() {
    local i
    for((i=0;i<${#output_line_array[@]};i++)); do
        echo $i\) ${output_line_array[$i]}
    done
}


# description: reverse array
# paras:
# return:
function reverse_output_array() {
    local temp_output_line_array=()
    local i
    for((i=${#output_line_array[@]}-1;i>=0;i--)); do
        temp_output_line_array[${#output_line_array[@]}-$i-1]=${output_line_array[$i]}
    done
    output_line_array=("${temp_output_line_array[@]}")
}


# description: check if array contains input value or not
# paras: para
# return: contains-0 other-1
function is_existed_in_array() {
    output_line_array_size=${#output_line_array[@]}
    local i
    for((i=0;i<$output_line_array_size;i++)); do
        if [[ ${output_line_array[$i]} == "$1" ]]; then
            return 0
        fi
    done
    return 1
}


# description: if output_line_array is large, choose to display or not
# paras:
# return: display-0 other-1
# TODO: this and re.sh
function choose_to_display_or_not() {
    if test ${#output_line_array[@]} -gt 25; then
        echo -e "total found: ${#output_line_array[@]}, display all? (y/N) \c"
        local select_op
        read select_op
        if [[ $select_op == '' || $select_op == 'n' || $select_op == 'N' ]]; then
            return 1
        elif [[ $select_op == 'y' || $select_op == 'Y' ]]; then
            return 0
        else
            echo 'select_output_line: please check your input'
            return 1
        fi
    else
        return 0
    fi
}
