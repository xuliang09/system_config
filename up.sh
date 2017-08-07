dir=`pwd`
if [[ "$#" -eq 0 ]]; then
	echo -e "$dir\c" | putclip
elif [[ "$#" -eq 1 ]]; then
	echo -e "${dir}/$1\c" | putclip
else
	echo "up: don't support multiple parameters"
fi