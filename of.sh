#!/bin/bash


function main() {
    local dir=`pwd`
    cd "$@"
    nautilus `pwd` &>/dev/null
    builtin cd $dir
}


main "$@"
