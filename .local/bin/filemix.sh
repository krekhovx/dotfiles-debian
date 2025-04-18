#!/bin/sh
#
# Rename all files of a specified format in the current directory to unique
# random names. Need to specify the file format ("txt", "jpg", etc.).
#

generate_random_string()
{
	tr -dc 'a-z0-9' < /dev/urandom | head -c 12
}

if [ -n "$1" ]; then
	for file in *.$1; do
		s=$(generate_random_string)

		while [ -e "${s}.$1" ]; do
			s=$(generate_random_string)
		done

		mv "$file" "${s}.$1"
	done
else
	>&2 echo "usage: $ $(basename $0) '<file-format>'"
fi
