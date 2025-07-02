#!/bin/sh
#
# Launch QEMU with the provided disk or ISO image option.
#

usage()
{
if [ $1 -eq 1 ]; then
	>&2 echo "Try '$(basename $0) --help' for more information."
	exit 1
else
cat << EOF
Usage: $(basename $0) [option]
Launch QEMU with the provided disk or ISO image option.

  [option]
  -qc, --qemu-cdrom </path/to/iso>          launch QEMU using a specified CD-ROM ISO
  -qch, --qemu-cdrom-hda </path/to/iso>     create a temporary disk and launch QEMU with it
  -qh, --qemu-hda </path/to/hda>            launch QEMU with specified hard disk image
  -h, --help                                show this help and exit

EOF

exit 0
fi
}

case "$1" in
'-qc'|'--qemu-cdrom')
	[ -z "$2" ] && usage 1
	qemu-system-x86_64 -boot d -cdrom "$2" -m 2048
	;;

'-qch'|'--qemu-cdrom-hda')
	[ -z "$2" ] && usage 1
	f=$(basename "$(mktemp -u)")
	qemu-img create -f qcow2 "/tmp/$f.img" 50G
	qemu-system-x86_64 -boot d -cdrom "$2" -m 2048 -hda "/tmp/$f.img" \
	-net nic -net user -enable-kvm -cpu host -smp "$(nproc)"
	;;

'-qh'|'--qemu-hda')
	[ -z "$2" ] && usage 1
	qemu-system-x86_64 -m 2048 -hda "$2" -net nic -net user \
	-enable-kvm -cpu host -smp "$(nproc)"
	;;

'-h'|'--help')
	usage 0
	;;

*)
	usage 1
	;;
esac
