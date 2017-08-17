dir=`pwd`
if [[ "$#" -eq 0 ]]; then
	echo "$dir" | putclip
elif [[ "$#" -eq 1 ]]; then
	echo "${dir}/$1" | putclip
else
	echo "up: don't support multiple parameters"
fi
