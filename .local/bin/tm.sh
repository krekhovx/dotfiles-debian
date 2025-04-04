#!/bin/sh
#
# Simple timer with a signal.
#

if [ -n "$1" ]; then
	echo "aplay ~/.local/share/prompt.wav" | \
	at now + "$1" minute
else
	>&2 echo "usage: $ $(basename $0) <minutes>"
	exit 1
fi
