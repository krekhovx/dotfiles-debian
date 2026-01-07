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
lcd baseq3
cd quake3
get *
bye
EOF
}

mkdir baseq3

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
sudo /usr/games/game-data-packager -n quake3 baseq3/*.pk3
sudo apt install -y ./*.deb
sudo rm ./*.deb
rm -rf baseq3

# download archive with new high-resolution textures
wget https://files.ioquake3.org/xcsv_hires.zip

# replace the textures from Quake 3 with new high-resolution textures
sudo unzip xcsv_hires.zip '*.pk3' -d /usr/share/games/quake3-data/baseq3
rm xcsv_hires.zip

# copy cd-key for ioquake3 (optional)
sudo cp misc/q3key /usr/share/games/quake3-data/baseq3
sudo chmod 644 /usr/share/games/quake3-data/baseq3/*

# delete host
ssh-keygen -R "$sftpip" >/dev/null 2>&1
