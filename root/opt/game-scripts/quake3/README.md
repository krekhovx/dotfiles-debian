## Quake III Arena
This script is created to simplify the installation and launch of Quake III
Arena with enhanced content and the latest updates from **ioquake3** port. It
downloads necessary open and proprietary files and automates the process of
preparing the game for launch on Debian.

## Installation

- Before installation, make sure that your machine has internet access.

- Run the installation script:
```
$ ./install.sh
```

- You can read the manual:
```
$ man quake3
```

- Enjoy the game:
```
$ q3
```

## Where are the game files stored?
```
~/.q3a/
```

## Configuration for 1920x1080
I've slightly modified the default configuration, changing some settings and
hotkeys to make it more convenient for playing. If you want to try it, run:
```
$ mkdir -p ~/.q3a/{baseq3,unfreeze}
$ cp misc/q3config.cfg ~/.q3a/baseq3 ~/.q3a/unfreeze ~/.q3a
$ cp misc/q3key ~/.q3a/baseq3 ~/.q3a
```

## Why should I use ioquake3 instead of id software’s 1.32c?
Answer from the
[ioquake3](https://ioquake3.org/help/players-guide/#whyioquake3):
*id software stopped fixing bugs, security issues, and adding features to Quake
3: Arena more than fifteen years ago. We’ve added many features and fixed too
many bugs to count.*

## HUNK_ALLOC FAILED
If you are experiencing network game interruptions due to this error, you can
increase the values by setting:
```
seta com_zoneMegs "<greater number>"
seta com_hunkMegs "<greater number>"
```
in the file ```~/.q3a/baseq3/q3config.cfg```

## Useful links

### Guides
- [Players Guide](https://ioquake3.org/help/players-guide/)
- [Sys Admin Guide](https://ioquake3.org/help/sys-admin-guide/)

### Project
- [GitHub](https://github.com/ioquake/ioq3)
- [Bug Tracker 1](https://github.com/ioquake/ioq3/issues)
- [Bug Tracker 2](https://bugzilla.icculus.org/describecomponents.cgi?product=ioquake3)
- [Site](https://ioquake3.org)

### Where can I find good maps to download?
- [Maps 1](https://lvlworld.com)
- [Maps 2](https://ws.q3df.org/maps/)
