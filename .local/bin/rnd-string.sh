#!/bin/sh
#
# Generate a random alphanumeric string of a specified length.
# Output the string to stdout or copy it to the clipboard.
#

usage()
{
if [ $1 -eq 1 ]; then
	>&2 echo "Try '$(basename $0) --help' for more information."
	exit 1
else
cat << EOF
Usage: $(basename $0) [option]
Generate a random alphanumeric string of a specified length.

  [option]
  -c, --clipboard <string-length>     output string to clipboard
  -s, --stdout <string-length>        output string to stdout
  -h, --help                          show this help and exit

EOF

exit 0
fi
}

case "$1" in
'-c'|'--clipboard')
	[ -z "$2" ] && usage 1
	tr -dc 'a-zA-Z0-9!@#' < /dev/urandom | head -c "$2" | xsel -b -i
	;;

'-s'|'--stdout')
	[ -z "$2" ] && usage 1
	tr -dc 'a-zA-Z0-9!@#' < /dev/urandom | head -c "$2" && echo
	;;

'-h'|'--help')
	usage 0
	;;

*)
	usage 1
	;;
esac
