#!/bin/sh
#
# Simple timer with a signal.
#

usage()
{
if [ $1 -eq 1 ]; then
	>&2 echo "Try '$(basename $0) --help' for more information."
	exit 1
else
cat << EOF
Usage: $(basename $0) [option]
Simple timer with a signal.

  [option]
  -atn, --at-now <minutes>         play sound after delay
  -atd, --at-delete                delete all time jobs
  -h, --help                       show this help and exit

EOF

exit 0
fi
}

case "$1" in
'-atn'|'--at-now')
	[ -z "$2" ] && usage 1
	if [ -e ~/.local/share/prompt.wav ]; then
		echo "aplay ~/.local/share/prompt.wav" | at now + "$2" minute
	else
		>&2 echo "File ~/.local/share/prompt.wav not exist."
		exit 1
	fi
	;;

'-atd'|'--at-delete')
	atq | awk '{print $1}' | xargs atrm 2>/dev/null
	;;

'-h'|'--help')
	usage 0
	;;

*)
	usage 1
	;;
esac
