#!/usr/bin/env bash
#
# Execute Git commands like 'clone', 'pull', or 'status' across multiple Git
# projects for easy management.
#

usage()
{
if (( $1 )); then
	>&2 echo "Try '$(basename $0) --help' for more information."
	exit 1
else
cat << EOF
$(echo -e "\e[96mUsage: $(basename $0) [options]\e[0m")
Multiple Git Control (simple git operations).

  [option]
  -cs, --clone-salsa                        clone my favorite Salsa projects in current directory
  -ck, --clone-krekhovx                     clone my GitHub projects in current directory
  -p, --pull </path/to/git/projects>        pull from the specified Git projects, all branches
  -s, --status </path/to/git/projects>      status from the specified Git projects, current branch
  -h, --help                                show this help and exit

EOF

exit 0
fi
}

git_command()
{
	option="$1" path="$2"

	if [ ! -d "$path" ]; then
		echo >&2 "'$dir' directory not exist."
		usage 1
	fi

	current_dirs="$(dirname $(find $path -type d -name '.git') 2>/dev/null)"

	if [ -z "$current_dirs" ]; then
		echo >&2 "'$path' there are no projects in this directory."
		exit 1
	fi

	for dir in ${current_dirs[*]}; do
		echo -e "\e[96m*** ---- $dir ---- ***\e[0m"
		cd "$dir"

		if [ "$option" == "pull" ]; then
			git fetch --all
			if git status | grep 'git pull' >/dev/null; then
				echo "git pull --all"
				git pull --all 2>/dev/null
			fi

			current_branch="$(git branch | grep '*' | awk '{print $2}')"
			branch_count="$(git branch | wc -l)"

			if (( branch_count > 1 )); then
				# git pull from all have branches
				# I want actual git log
				branches=$(git branch --format='%(refname:short)')
				for b in ${branches[*]}; do
					git checkout "$b"
					if git status | grep 'git pull' >/dev/null; then
						echo "git pull: $b"
						git "$option" 2>/dev/null
					fi
				done

				# go back to the 'master' branch
				git checkout "$current_branch"
			fi
		fi

		if [ "$option" == "status" ]; then
			git "$option"
		fi

		cd - >/dev/null
		echo
	done
}

clone_salsa()
{
	dir=$1
	list=($2)

	mkdir $dir 2>/dev/null

	for name in ${list[*]}; do
		vcs=$(apt-get source --print-uris "$name" 2>/dev/null | grep -E 'https|salsa' | head -1)
		if [ -z "$vcs" ]; then
			echo >&2 "$name is not loaded on salsa."
			echo; continue
		fi

		sdir=$(basename 2>/dev/null $(basename "$vcs" .git))
		if [ ! -d "$dir/$sdir" ]; then
			git clone "$vcs" "$dir/$sdir"
			echo
		fi
	done
}

case "$1" in
	# clone my GitHub projects
	'-ck'|'--clone-krekhovx')
		projects=(krekhovx krxnotes dotfiles-debian
		pbuilder-amd64-helper quake3-terminal-theme)

		for name in ${projects[*]}; do
			if [ ! -d "$name" ]; then
				git clone "git@github.com:krekhovx/$name"
				echo
			fi
		done
	;;

	# clone my favorite Salsa projects
	'-cs'|'--clone-salsa')
		# packages I monitor
		watch_packages=(xfce4-terminal xterm mc tmux vim \
		how-can-i-help popularity-contest telegram-desktop \
		systemd strace eatmydata)

		xfce_packages=$(grep-aptavail -F Maintainer -s Package -n \
		"Debian Xfce Maintainers <debian-xfce@lists.debian.org>")

		vim_packages=$(grep-aptavail -F Maintainer -s Package -n \
		"Debian Vim Maintainers <team+vim@tracker.debian.org>")

		clone_salsa "watch" "${watch_packages[*]}"
		clone_salsa "xfce" "${xfce_packages[*]}"
		clone_salsa "vim" "${vim_packages[*]}"
	;;

	'-p'|'--pull')
		[ -z "$2" ] && usage 1
		git_command "pull" "$2"
	;;

	'-s'|'--status')
		[ -z "$2" ] && usage 1
		git_command "status" "$2"
	;;

	'-h'|'--help') usage 0 ;;

	*) usage 1 ;;
esac
