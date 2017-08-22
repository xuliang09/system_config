#!/usr/bin/env bash

# description: escape regex char
# paras: para
# return:
escape_regex_char() {
    dup_str=$*
    dup_str_ret=''
    for((i=0;i<${#dup_str};i++)); do
        if [[ ${dup_str:i:1} == '$' ]]; then
            dup_str_ret+='\$'
        elif [[ ${dup_str:i:1} == '^' ]]; then
            dup_str_ret+='\^'
        elif [[ ${dup_str:i:1} == '*' ]]; then
            dup_str_ret+='\*'
        elif [[ ${dup_str:i:1} == '[' ]]; then
            dup_str_ret+='\['
        elif [[ ${dup_str:i:1} == ']' ]]; then
            dup_str_ret+='\]'
        elif [[ ${dup_str:i:1} == '\' ]]; then
            dup_str_ret+='\\'
        elif [[ ${dup_str:i:1} == '/' ]]; then
            dup_str_ret+='\/'
        else
            dup_str_ret+=${dup_str:i:1}
        fi
    done

    echo "$dup_str_ret"
}
