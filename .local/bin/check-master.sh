#!/bin/sh
#
# Analyze an audio file before uploading to platforms.
#

if [ -n "$1" ]; then
	audio="$1"
	ffmpeg -i "$audio" -af loudnorm=I=-10:TP=-1.0:LRA=11:print_format=summary -f null -
else
	>&2 echo "usage: $ $(basename "$0") <audio.wav>"
	exit 1
fi
