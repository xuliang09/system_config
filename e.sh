#!/usr/bin/env bash

function main() {
    emacsclient $@ &>/dev/null &
}

main $@
