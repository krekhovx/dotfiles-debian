#!/usr/bin/env bash
#
# Stupid script for fetching source codes.
# My favorite Debian packages here (for maintenance work).
#

# packages I monitor
watch_packages=(xfce4-terminal xterm mc tmux vim \
how-can-i-help popularity-contest telegram-desktop \
systemd strace eatmydata)

xfce_packages=$(grep-aptavail -F Maintainer -s Package -n \
"Debian Xfce Maintainers <debian-xfce@lists.debian.org>")

vim_packages=$(grep-aptavail -F Maintainer -s Package -n \
"Debian Vim Maintainers <team+vim@tracker.debian.org>")

get_sources()
{
	dir=$1
	list=($2)

	mkdir ~/sources 2>/dev/null
	mkdir ~/sources/$dir 2>/dev/null

	for pkg in ${list[*]}; do
		[ ! -d ~/sources/$dir/sid-$pkg ] && mkdir ~/sources/$dir/sid-$pkg || continue
		cd ~/sources/$dir/sid-$pkg
		apt-get source $pkg
	done
}

apt-get update
get_sources "watch" "${watch_packages[*]}"
get_sources "xfce" "${xfce_packages[*]}"
get_sources "vim" "${vim_packages[*]}"

cd ~
