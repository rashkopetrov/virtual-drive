[Go Back](https://github.com/rashkopetrov/virtual-drive/)

You will be asked for a root password to escalate the permissions.

```txt
Working with virtual drives requires root permissions
The normal user accounts don't have rights to
  * mount filesystems
  * unmount filesystems

Please enter your root password to proceed
Password:
```

## Examples

`Creating a virtual drive`

```txt
username@debian# virtual-drive create --name myVault
Virtual Drive v0.21.11.20 Copyright (c) 2021, Rashko Petrov

Creating a virtual drive. It might take a while...
507510784 bytes (508 MB, 484 MiB) copied, 13 s, 39.0 MB/s
512+0 records in
512+0 records out
536870912 bytes (537 MB, 512 MiB) copied, 13.7641 s, 39.0 MB/s
Creating ext4 filesystem...
mke2fs 1.44.5 (15-Dec-2018)
Discarding device blocks: done
Creating filesystem with 131072 4k blocks and 32768 inodes
Filesystem UUID: 180413a5-6896-4d64-9a87-2d53bbdcd7b0
Superblock backups stored on blocks:
    32768, 98304

Allocating group tables: done
Writing inode tables: done
Creating journal (4096 blocks): done
Writing superblocks and filesystem accounting information: done

Virtual drive has been sucessfully created
  ==> /home/username/VirtualDrives/Vaults/myVault.img

Use the following command to mount it:
  ==> virtual-drive mount --name myVault
```

`Mount the virtual drive`

```txt
username@debian# virtual-drive mount --name myVault
Virtual Drive v0.21.11.20 Copyright (c) 2021, Rashko Petrov

Creating a mount directory...
  ==> /mnt/VirtualDrives/myVault
Mounting the virtual drive...
  ==> this directory is mounted as root user
  ==> /home/username/VirtualDrives/Vaults/myVault.img
Binding the mounted directory with user permissions
  ==> this directory is mounted as the user running the script
  ==> /home/username/VirtualDrives/Mounted/myVault
To open the directory from the terminal
  ==> xdg-open /home/username/VirtualDrives/Mounted/myVault

myVault has been mounted
```

`Unmount the virtual drive`

```txt
username@debian# virtual-drive unmount --name myVault
Virtual Drive v0.21.11.20 Copyright (c) 2021, Rashko Petrov

Unmounting /mnt/VirtualDrives/myVault
Removing the mount directory
  ==> /mnt/VirtualDrives/myVault
Removing the bind directory
  ==> /home/username/VirtualDrives/Mounted/myVault

myVault has been unmounted
```

`List the virtual drives`

```txt
username@debian# virtual-drive list
Virtual Drive v0.21.11.20 Copyright (c) 2021, Rashko Petrov

myVault1	10M
myVault2	10M
myVault     10M
```
