#!/bin/sh
#
# Reminds you to take an eye break from work.
#

message="Take a break!
Give your eyes some rest — look out the window,
the world is beautiful!"

if [ -e ~/.local/share/prompt.wav ]; then
	echo "aplay ~/.local/share/prompt.wav; DISPLAY=$DISPLAY zenity --info \
	--text=\"$message\"" | at now + 40 minutes
else
	>&2 echo "File ~/.local/share/prompt.wav not exist."
	exit 1
fi
