#!/bin/sh
#
# Automate the process of writing a message, signing it with GPG.
#

usage()
{
if [ $1 -eq 1 ]; then
	>&2 echo "Try '$(basename $0) --help' for more information."
	exit 1
else
cat << EOF
Usage: $(basename $0) [option]
Automate message writing and GPG signing.

  [option]
  -c, --clearsign      clear-sign and copy
  -d, --detachsign     detach-sign and copy
  -h, --help           show this help and exit

EOF

exit 0
fi
}

case "$1" in
'-c'|'--clearsign')
	text=$(mktemp) && vim $text
	gpg --clearsign $text
	shred -uzn 8 $text
	xsel -b -i < $text
	shred -uzn 8 $text.asc
	echo "> paste signed text from clipboard"
	;;

'-d'|'--detachsign')
	text=$(mktemp) && vim $text
	gpg --detach-sign --armor -o ~/signature.asc $text
	xsel -b -i < $text
	shred -uzn 8 $text
	echo "> paste signed text from clipboard"
	echo "> attach signature.asc"
	;;

'-h'|'--help')
	usage 0
	;;

*)
	usage 1
	;;
esac
