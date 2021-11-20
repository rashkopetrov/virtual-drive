[Go Back](https://github.com/rashkopetrov/virtual-drive/)

## Examples

Creating a virtual drive

```txt
username@debian# virtual-drive create --name myVirtualDrive
Virtual Drive v0.21.11.18 Copyright (c) 2021, Rashko Petrov

Creating a virtual drive. It might take a while...
529530880 bytes (530 MB, 505 MiB) copied, 12 s, 44.1 MB/s
512+0 records in
512+0 records out
536870912 bytes (537 MB, 512 MiB) copied, 12.1941 s, 44.0 MB/s
Creating ext4 filesystem...
mke2fs 1.46.2 (28-Feb-2021)
Discarding device blocks: done
Creating filesystem with 131072 4k blocks and 32768 inodes
Filesystem UUID: f3fa6c2f-8dcd-4ca7-9018-0bfebeca2a33
Superblock backups stored on blocks:
	32768, 98304

Allocating group tables: done
Writing inode tables: done
Creating journal (4096 blocks): done
Writing superblocks and filesystem accounting information: done

Virtual drive has been sucessfully created
  ==> /home/username/VirtualDrives/myVirtualDrive.img

Use the following command to mount it:
  ==> virtual-drive mount --name myVirtualDrive
```

Mount the virtual drive

```txt
username@debian# virtual-drive mount --name myVirtualDrive
Virtual Drive v0.21.11.18 Copyright (c) 2021, Rashko Petrov

Creating a mount directory...
  ==> /mnt/VirtualDrives/myVirtualDrive
Mounting the virtual drive...
  ==> /home/username/VirtualDrives/myVirtualDrive.img

myVirtualDrive has been mounted
```

Unmount the virtual drive

```txt
username@debian# virtual-drive unmount --name myVirtualDrive
Virtual Drive v0.21.11.18 Copyright (c) 2021, Rashko Petrov

Unmounting /mnt/VirtualDrives/myVirtualDrive
Removing the mount directory
  ==> /mnt/VirtualDrives/myVirtualDrive

myVirtualDrive has been unmounted
```
