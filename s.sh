#!/bin/bash

output_line_array=('https://www.bing.com/search?q=keyword'
                   'https://www.baidu.com/s?wd=keyword'
                   'https://github.com/search?utf8=✓&q=keyword')


# return index of search engine in output_line_array
function select_one_search_engine() {
    display_output_line_array
    s_select_output_line
    return $?
}


function s_select_output_line() {
    echo -e "=> \c"
    local select_number
    read select_number

    select_output_line "$select_number"
    local select_output_line_ret="$?"

    if [[ $select_output_line_ret -ge 0 && $select_output_line_ret -lt ${#output_line_array[@]} ]]; then
        return $select_output_line_ret
    elif [[ $select_output_line_ret -eq ${#output_line_array[@]} ]]; then
        display_output_line_array
        s_select_output_line
    else
        echo 's: please check your input'
    fi
}


function main() {
    select_one_search_engine "$@"

    local selected_engine_index=$?
    local keywords="$*"
    local url
    if [[ $selected_engine_index -ge 0 && $selected_engine_index -lt ${#output_line_array[@]} ]]; then
        local selected_engine="${output_line_array[$selected_engine_index]}"
        url="${selected_engine//keyword/${keywords}}"
    else
        return 1
    fi
    if [[ $url != '' ]]; then
        firefox "${url}" &>/dev/null
    fi
}


main "$@"
