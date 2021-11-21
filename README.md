# Virtual Drive bash script

A script that helps you to create and mount virtual drives with ease.

## Installation

[Installation manual](https://github.com/rashkopetrov/virtual-drive/blob/master/README-INSTALLATION.md)

## Usage

-   Help text:
    -   `virtual-drive --help`
-   Create a virtual drive:
    -   `virtual-drive create --name myVault`
-   Create a virtual drive (100MB):
    -   `virtual-drive create --name myVault --size 100`
-   Create a virtual drive and mount it:
    -   `virtual-drive create --mount --name myVault`
-   Mount the virtual drive
    -   `virtual-drive mount --name myVault`
-   Unmount the virtual drive
    -   `virtual-drive unmount --name myVault`
-   Delete the virtual drive
    -   `virtual-drive delete --name myVault`
-   List all virtual drives
    -   `virtual-drive list`
-   List only mounted virtual drives
    -   `virtual-drive list --list-mounted`
-   Resize the virtual drive (new size 200MB)
    -   `virtual-drive resize --name myVault --size 200

## Examples

[Examples](https://github.com/rashkopetrov/virtual-drive/blob/master/README-EXAMPLE.md)

## Credits

-   [Create an encrypted file vault on Linux](https://opensource.com/article/21/4/linux-encryption)
-   [How do I create an encrypted filesystem inside a file?](https://askubuntu.com/questions/58935/how-do-i-create-an-encrypted-filesystem-inside-a-file)
-   [How To Use DM-Crypt to Create an Encrypted Volume on an Ubuntu VPS](https://www.digitalocean.com/community/tutorials/how-to-use-dm-crypt-to-create-an-encrypted-volume-on-an-ubuntu-vps)
-   [How to Set Up Virtual Disk Encryption on GNU/Linux that Unlocks at Boot](https://leewc.com/articles/how-to-set-up-virtual-disk-encryption-linux/)
