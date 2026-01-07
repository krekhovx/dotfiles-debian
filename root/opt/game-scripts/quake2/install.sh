#!/bin/sh

set -e

if [ "$(id -u)" -eq 0 ]; then
	>&2 echo "Please, execute this script as a non-root user."
	exit 1
fi

umask 022

download_data_files()
{
sshpass -p '1' sftp sftpuser@5.63.158.181 <<EOF
lcd baseq2
cd quake2
get *
bye
EOF
}

mkdir baseq2

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
download_data_files

# install data package
sudo /usr/games/game-data-packager -n quake2 baseq2/*.pak
sudo apt install -y ./*.deb
sudo rm ./*.deb
rm -rf baseq2

# delete host
ssh-keygen -R "$sftpip" >/dev/null 2>&1
