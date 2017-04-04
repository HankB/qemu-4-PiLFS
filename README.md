# qemu-4-PiLFS

## Purpose

* Script a working environment to build LFS using QEMU on Linux.
* Add scripting for the remaining operations to build a working LFS install for a Raspberry Pi (model B 2 or three.)

## Overview

Snag a copy of a Raspberry Pi image and run it in a QEMU VM (?) in order to build on more potent H/W. In this case Raspbian Lite is the target OS. To gain space it is copied to a micro-SD card and then the partitions are resized and formatted using `gparted` on the host system. The resulting card image is copied off to a disk file which can then be mounted as loop devices and uysed as the host file system for `qemu`. The actual build relies heavily on the scripts found at https://github.com/pilfs/scripts and the instructions provided at http://www.intestinate.com/pilfs/.

## Requirements

* A working Linux system. Debian Stretch (9, RC) is used here.
* packages qemu-user-static, kpartx (and probably others I'm overlooking.)

## Procedure

### Prepare a suitable image file

It seems to make sense that a fair amount of disk space would be required to build a complete Linux system.
There is probably a way to manipulate the file directly to do this but to save the time researching this,
the easy way to do this is to:

* Copy a standard image to a suitably sized micro-SD card. (16GB)
* Expand the root file system to allow space to install build tools. (4GB)
* Add an additional partition for the LFS build (8GB)
* Copy the micro-SD to a .img file

(Process is not yet complete so the sizes may require revision)

### Run QEMU

Fire up the QEMU instance by executing `qemu.sh`. If all goes well, yuo will be presented with a root prompt in the QEMU instance.

### Prepare the environment

TBD (At present you can copy/paste commands from lfs-commands)

## Status

### Done

* Working QEMU running as ARM (armv7l)
* Using scripts from https://github.com/pilfs/scripts work completed through Chapter 5.

### TODO

* Script additional login for user 'lfs.'
* Script other settings such as symlink for sh -> bash.
* Script capture of kpartx output to get mounts right. (loop0 vs.loop[n].)
* Script download of all sources if needed. (Low priority)
