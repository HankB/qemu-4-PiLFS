#!/bin/bash
# Set up to run raspberry Pi code in preparation for PiLFS (Linux From Scratch.)
#
# First step - copy image to a 16GB SSD card, expand file systems (/ to 4096 
# and add another 8192 partition) And when complete, dd the SD to an .img file
# 


# mount relative to the corrent directory
export MNT=mnt/rpi

# name of IMG file we'll use (with /boot, / and /lfs partitions as described above.)
export IMG=2017-03-02-raspbian-jessie-lite-expanded.img

mkdir -p $MNT

sudo kpartx -a -v $IMG
# takes a bit of time before the mapper devs are ready
sleep 1

# /dev files assume this is the first loop device created.(loop0)
sudo mount /dev/mapper/loop0p2 $MNT
sudo mount /dev/mapper/loop0p1 $MNT/boot

sudo mkdir -p ${MNT}/lfs
sudo mount /dev/mapper/loop0p3 $MNT/lfs

sudo cp `which qemu-arm-static` ${MNT}/usr/bin/

sudo mount -o bind /dev ${MNT}/dev
sudo mount -o bind /proc ${MNT}/proc
sudo mount -o bind /sys ${MNT}/sys

sudo bash -c "echo ':arm:M::\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x28\x00:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff:/usr/bin/qemu-arm-static:' >/dev/null /proc/sys/fs/binfmt_misc/register"

sudo chroot $MNT
# and do stuff...

# unwind/clean up
sudo umount ${MNT}/dev ${MNT}/proc ${MNT}/sys ${MNT}/boot ${MNT}/lfs ${MNT} 
sudo kpartx -d -v $IMG
