# Virtual Drive bash script

A script that helps you to create and mount virtual drives with ease.

## Installation:

## Prerequisite

-   cryptsetup

## Prerequisite Installation

**Debian & Debian-based Linux distributions:**

```bash
apt update
apt install cryptsetup -y
```

### Install the script

Assuming that the repository files are located in `~/.virtual-drive`.

**Method 1** : Add an alias in .bashrc

With this method virtual-drive can only be used by the current user.

```bash
echo "alias virtual-drive=$HOME/.virtual-drive/virtual-drive.sh" >> $HOME/.bashrc
source $HOME/.bashrc
```

**Method 2** : Copy the `virtual-drive.sh` script itself to ~/.local/bin and remove the `~/.virtual-drive` directory

With this method `virtual-drive` command can only be used by the current user. Only the script file is kept on your machine and not the entire GitHub repository.

```bash
cp $HOME/.virtual-drive/virtual-drive.sh $HOME/.local/bin/virtual-drive
chmod +x $HOME/.local/bin/virtual-drive
rm -rf $HOME/.virtual-drive
```

**Method 3** : Add an alias to the script in /usr/local/bin

With this method `virtual-drive` can be used by all users.

```bash
sudo ln -s $HOME/.virtual-drive/optimize.sh /usr/local/bin/virtual-drive
sudo chmod +x /usr/local/bin/virtual-drive
```

## Usage

To see the help text, simply type `virtual-drive --help` in your terminal.

```txt
username@debian# virtual-drive --help
Virtual Drive v0.21.11.18 Copyright (c) 2021, Rashko Petrov

Usage: virtual-drive <command> [OPTIONS...]
Create/Mount virtual drives with ease.

Commands:

  create
  mount
  unmount
  list
  fix

Options:

  -v, --version    Print version information and quit

Examples:
  virtual-drive                     Prints the help text
  virtual-drive --version           Prints the current version
  virtual drive <command> --help    Prints the help text for the given command
```

## Example

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

## Credits

-   [Create an encrypted file vault on Linux](https://opensource.com/article/21/4/linux-encryption)
-   [How do I create an encrypted filesystem inside a file?](https://askubuntu.com/questions/58935/how-do-i-create-an-encrypted-filesystem-inside-a-file)
-   [How To Use DM-Crypt to Create an Encrypted Volume on an Ubuntu VPS](https://www.digitalocean.com/community/tutorials/how-to-use-dm-crypt-to-create-an-encrypted-volume-on-an-ubuntu-vps)
-   [How to Set Up Virtual Disk Encryption on GNU/Linux that Unlocks at Boot](https://leewc.com/articles/how-to-set-up-virtual-disk-encryption-linux/)
