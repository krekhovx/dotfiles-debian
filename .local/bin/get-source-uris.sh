#!/bin/sh
#
# Get source package URIs for a given command or path.
#
# Examples:
# $ get-source-uris.sh /bin/bash
# $ get-source-uris.sh scp
#

if [ -n "$1" ]; then
	cmdpath=$(which "$1" 2>/dev/null)

	if [ -n "$cmdpath" ]; then
		pack=$(dpkg -S "$cmdpath" 2>/dev/null | awk '{print $1}' | sed 's/:$//')
	fi

	if [ -n "$pack" ]; then
		sudo apt-get source --print-uris "$pack" 2>&1 | awk '
		/^NOTICE:/ {print $NF}
		/http/ {
			match($0, /(http[^[:space:]'\''"]+)/, url)
			if (url[1] != "") print url[1]
		}' | grep -v '^at:' | uniq
	else
		echo "not found name: $1"
		exit 1
	fi
else
	>&2 echo "usage: $ $(basename $0) <command>|<path>"
	exit 1
fi
