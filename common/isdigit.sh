#!/bin/bash


# description: check a varible is integer or not
# paras: para
# return: is integer-0 other-1
function isdigit() {
    expr $1 + 1 &>/dev/null
    if [[ $? -eq 0 ]]; then
        return 0
    fi

    expr $1 + 2 &>/dev/null
    if [[ $? -eq 0 ]]; then
        return 0
    fi

    return 1
}
