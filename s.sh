#!/bin/bash

search_engine_list=('https://www.bing.com/search?q=keyword'
                    'https://www.baidu.com/s?wd=keyword')
selected_engine_index=-1
url=


# return index of search engine in search_engine_list
function select_one_search_engine() {
    output_search_engine_list
    select_output_line
}


# substitute keyword with true "keyword"
function substitute_engine_keyword() {
    keywords="$@"
    selected_engine="${search_engine_list[$selected_engine_index]}"
    url="${selected_engine//keyword/${keywords}}"
}


function output_search_engine_list() {
    for((i=0; i<${#search_engine_list[@]}; i++)); do
        echo ${i}\) ${search_engine_list[$i]}
    done
}


function select_output_line() {
	  echo -e "=> \c"
	  read select_number

    if [[ "$select_number" == '' ]]; then
        select_number=0
    fi

    isdigit "$select_number"
    isdigit_state="$?"
    if [[ $isdigit_state -eq 0 && $select_number -lt ${#search_engine_list[@]} ]]; then
        selected_engine_index=$select_number
    elif [[ $isdigit_state -ne 0 ]]; then
		    temp_search_engine_list=()
		    for((i=0;i<${#search_engine_list[@]};i++));
		    do
			      line=${search_engine_list[$i]}
			      match_line "$select_number" "$line"

			      if [ $? -eq 0 ]; then
				        temp_search_engine_list[i]=$line
			      fi
		    done
		    search_engine_list=("${temp_search_engine_list[@]}")
		    if [[ ${#search_engine_list[@]} -eq 0 ]]; then
			      echo 's: found no engine'
			      return 0
        elif [[ ${#search_engine_list[@]} -eq 1 ]]; then
            selected_engine_index=0
            return 0
		    fi
        output_search_engine_list
		    select_output_line
	  elif [[ $select_number -ge ${#search_engine_list[@]} ]]
	  then
		    echo 's: input incorrect!'
	  else
		    echo 's: select_output_line unexcepted case'
	  fi
}


function isdigit()
{
	  expr $1 + 1 &>/dev/null
	  return $?
}


function match_line()
{
	  line=${!#}
	  for para in $@
	  do
		    if [[ ! "$line" =~ "$para" ]]
		    then
			      return 1
		    fi
	  done
	  return 0
}


select_one_search_engine
substitute_engine_keyword "$@"
firefox "${url}" &>/dev/null
