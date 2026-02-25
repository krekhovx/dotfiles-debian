#!/bin/sh

# FIXME: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1104851
# If the package is accepted into Debian, it would be great to use
# 'game-data-packager' for installing the game in this script.
# --
# I have bad news (rejected):
# https://dfsg-new-queue.debian.org/reviews/devilutionx
# https://github.com/diasurgical/DevilutionX/discussions/7556

set -e

if [ "$(id -u)" -eq 0 ]; then
	>&2 echo "Please, execute this script as a non-root user."
	exit 1
fi

umask 022

download_data_files()
{
sshpass -p '1' sftp sftpuser@5.63.158.181 <<EOF
lcd data
cd diablo1
get *
bye
EOF
}

missing_packages_info()
{
cat << EOF
Please, install 'devilutionx-data', 'devilutionx' packages.
These packages are included in the 'diablo1/packages' directory.
EOF
}

for p in devilutionx-data devilutionx; do
	if ! dpkg -l | awk '{print $2}' | grep "^${p}$" >/dev/null 2>&1; then
		missing_packages_info
		exit 1
	fi
done

mkdir data

if [ ! -d ~/.ssh ]; then
	mkdir ~/.ssh
	chmod 700 ~/.ssh
fi

# know this host (SFTP server with game data files)
sftpip="5.63.158.181"
if ! ssh-keygen -F "$sftpip" >/dev/null 2>&1; then
	ssh-keyscan -H "$sftpip" >> ~/.ssh/known_hosts
fi

# download game data files from SFTP server
echo
echo "Data files extracted from:"
echo "setup_diablo_1.09_hellfire_v4_(78466).exe"
echo
download_data_files

# delete host
ssh-keygen -R "$sftpip" >/dev/null 2>&1
