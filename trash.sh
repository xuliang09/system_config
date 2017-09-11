#!/bin/bash
function trash() {
    if test ! -e ~/system_config/.cache/.trash; then
        mkdir ~/system_config/.cache/.trash
    fi

    mv -f $@ ~/system_config/.cache/.trash
}

function main() {
    trash $@
}

main $@
