#!/bin/bash


# description: check if line contains all paras
# paras: para1 ... paran line
# return: contains all-0 other-1
function match_line() {
    local para_idx=1
    local para_num=$#
    local select_output_line_para
    for select_output_line_para in $@; do
        if [[ $para_idx -eq $para_num ]]; then
            break
        fi
        select_output_line_para=${select_output_line_para//\+/\\\+}
        if [[ ! ${!#} =~ ${select_output_line_para} ]]; then
            return 1
        fi

        let para_idx++
    done
    return 0
}
