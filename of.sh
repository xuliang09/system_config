dir=`pwd`
if [[ "$#" -eq 0 ]]; then
	nautilus "$dir" &>/dev/null
else
	for para in $@; do
		nautilus "${dir}/${para}" &>/dev/null
	done
fi