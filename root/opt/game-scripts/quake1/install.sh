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
lcd id1
cd quake1
get *
bye
EOF
}

mkdir id1

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
sudo /usr/games/game-data-packager -n quake id1/*.pak
sudo apt install -y ./*.deb
sudo rm ./*.deb
rm -rf id1

# replace the textures from Quake with new high-resolution textures
sudo wget -P /usr/share/games/quake/id1 \
https://icculus.org/twilight/darkplaces/files/rygel-dp-texturepack-high.pk3
sudo chmod 644 /usr/share/games/quake/id1/*

# delete host
ssh-keygen -R "$sftpip" >/dev/null 2>&1
