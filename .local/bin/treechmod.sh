#!/bin/sh
#
# Recursively set file and directory permissions in <directory> using the given umask.
#

usage() {
if [ $1 -eq 1 ]; then
	>&2 echo "Try '$(basename $0) --help' for more information."
	exit 1
else
cat << EOF
Usage: $(basename $0) <umask> <directory>
Recursively set file and directory permissions in <directory> using the given umask.

  <umask>        3-digit octal umask value
  <directory>    path to the target directory

  [option]
  -h, --help     show this help and exit

  Examples:
  $(basename $0) 022 /path/to/dir
  $(basename $0) 077 .

EOF

exit 0
fi
}

case "$1" in
[0-7][0-7][0-7])
	[ $# -ne 2 ] && usage 1

	umask_val="$1"
	target_dir="$2"

	if [ ! -d "$target_dir" ]; then
		echo "Directory '$target_dir' does not exist" >&2
		exit 1
	fi

	dir_mode=$(printf "%03o" $(( 0777 & (0777 ^ 0$umask_val) )))
	file_mode=$(printf "%03o" $(( 0666 & (0777 ^ 0$umask_val) )))

	echo "File mode:      $file_mode"
	echo "Directory mode: $dir_mode"
	echo "Absolute directory path: $(realpath "$target_dir")"

	find "$target_dir" -type d -exec chmod "$dir_mode" {} +
	find "$target_dir" -type f -exec chmod "$file_mode" {} +
	;;

'-h'|'--help')
	usage 0
	;;

*)
	usage 1
	;;
esac
