#!/usr/bin/env bash
#
# Remove 'rc' (removed but not purged) packages
# plus debs autoremove and autoclean.
#

sudo apt-get autoremove -y
sudo apt-get autoclean

dpkg -l | awk '/^rc/{print $2}' | xargs sudo apt-get purge -y
