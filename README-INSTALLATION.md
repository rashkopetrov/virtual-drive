[Go Back](https://github.com/rashkopetrov/virtual-drive/)

## Prerequisite

-   bindfs

## Prerequisite Installation

**Debian & Debian-based Linux distributions:**

```bash
apt update
apt install -y bindfs
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
sudo ln -s $HOME/.virtual-drive/virtual-drive.sh /usr/local/bin/virtual-drive
sudo chmod +x /usr/local/bin/virtual-drive
```

## Usage

To see the help text, simply type `virtual-drive --help` in your terminal.

```txt
username@debian# virtual-drive --help
Virtual Drive v0.21.11.20 Copyright (c) 2021, Rashko Petrov

Usage: virtual-drive <command> [OPTIONS...]
Create/Mount virtual drives with ease.

Commands:

  create
  mount
  unmount|umount
  list
  fix
  resize

Options:

  -v, --version    Print version information and quit

Examples:
  virtual-drive                     Prints the help text
  virtual-drive --version           Prints the current version
  virtual drive <command> --help    Prints the help text for the given command
```
