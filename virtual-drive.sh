#!/bin/bash
# ###########################################
# Title           :Virtual Drive
# Description     :A script that creates, mounts, and unmounts virtual drives with ease.
# Author          :Rashko Petrov
# Website         :https://rashkopetrov.dev
# GitHub          :https://github.com/rashkopetrov/virtual-drive
# Date            :2021-11-20
# Version         :0.21.11.20
# Usage           :bash virtual-drive.sh
# OS/Bash         :Debian 10
#                 :Debian 11
#                 :GNU bash 5.1.4
#                 :GNU bash 5.0.1
# License         :MIT License
#                 :Copyright (c) 2021 Rashko Petrov
# ###########################################
#            “Clean code always
#     looks like it was written
#        by someone who cares.“
#
#           -- Michael Feathers
#############################################

# ===========================================
    # Variables
# ===========================================

# majorVersion.year.month.day
VERSION="0.21.11.20"

NC="\033[0m" # No Colo
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"

CURRENT_USER_HOME=~/
CURRENT_USER_NAME=$(whoami)
CURRENT_USER_ID=$(id -u)
CURRENT_USER_GROUP_ID=$(id -g)

MNT_DIRECTORY_NAME="VirtualDrives"
WORKSPACE_DIRECTORY_NAME="VirtualDrives"

VD_COMMAND="" # create|mount|unmount|umount|list|fix
VD_VAULT_NAME=""
VD_VAULT_IS_ENCRYPTED="" # <empty>|y
VD_VAULT_OPEN_AFTER_MOUNT="" # <empty>|y
VD_VAULT_MOUNT_AFTER_CREATE="" # <empty>|y
VD_VAULT_LIST="all" # unmounted|mounted|all
VD_VAULT_FILE_PATH=""

# ===========================================
    # Helpers/Utils
# ===========================================

printCopyright () {
    printText text "Virtual Drive v$VERSION Copyright (c) 2021, Rashko Petrov"
    printText nl
}

printHelp () {
    case "$VD_COMMAND" in
        create)
            printText text "Command: Create"
            printText text "Usage: virtual-drive create [OPTIONS...]"
            printText nl
            printText text "Create a new virtual drive"
            printText nl
            printText text "Options:"
            printText nl
            printText text "  --name         The name of the virtual drive"
            printText text "  --encrypted    Whether the drive to be password proteced or not"
            printText text "                     You will be asked for a passphrase during the set"
            printText text "  --mount        Mount the newly created virtual drive"
            printText text "  --open         Opens the mounted drive with Nautilus"
            printText text "                     The '--mount' option is required"
            printText nl
            printText text "Examples:"
            printText text "  virtual-drive --name mySecretVault"
            printText text "  virtual-drive --encrypted --name mySecretVault"
        ;;

        mount)
            printText text "Command: Mount"
            printText text "Usage: virtual-drive mount [OPTIONS...]"
            printText nl
            printText text "Mount a particular virtual drive"
            printText nl
            printText text "Options:"
            printText nl
            printText text "  --name         The name of the virtual drive"
            printText text "  --open         Opens the mounted drive with Nautilus"
            printText nl
            printText text "Examples:"
            printText text "  virtual-drive mount --name mySecretVault"
        ;;

        unmount | umount)
            printText text "Command: Unmount"
            printText text "Usage: virtual-drive unmount [OPTIONS...]"
            printText nl
            printText text "Unmount a particular virtual drive"
            printText nl
            printText text "Options:"
            printText nl
            printText text "  --name         The name of the virtual drive"
            printText nl
            printText text "Examples:"
            printText text "  virtual-drive unmount --name mySecretVault"
        ;;

        list)
            printText text "Command: List"
            printText text "Usage: virtual-drive list [OPTIONS...]"
            printText nl
            printText text "List all available|mounted virtual drives"
            printText nl
            printText text "Options:"
            printText nl
            printText text "  --list-mounted    List only mounted virtual drives"
            printText nl
            printText text "Examples:"
            printText text "  virtual-drive list"
        ;;

        fix)
            printText text "Command: Fix"
            printText text "Usage: virtual-drive fix [OPTIONS...]"
            printText nl
            printText text "Attempts to fix improperly unmounted virtual drive"
            printText text "Such drive could be one that wasn't unmouted before"
            printText text "  shutting down the PC"
            printText nl
            printText text "Options:"
            printText nl
            printText text "  --name         The name of the virtual drive"
            printText nl
            printText text "Examples:"
            printText text "  virtual-drive list"
        ;;
    *)

    printText text "Usage: virtual-drive <command> [OPTIONS...]"
    printText text "Create/Mount virtual drives with ease."
    printText nl
    printText text "Commands:"
    printText nl
    printText text "  create"
    printText text "  mount"
    printText text "  unmount|umount"
    printText text "  list"
    printText text "  fix"
    printText nl
    printText text "Options:"
    printText nl
    printText text "  -v, --version    Print version information and quit"
    printText nl
    printText text "Examples:"
    printText text "  virtual-drive                     Prints the help text"
    printText text "  virtual-drive -v                  Prints the current version"
    printText text "  virtual drive <command> --help    Prints the help text for specific command"
    esac

    return 0
}

printText () {
    case "$1" in
        nl)
            printf "\n"
        ;;

        text)
            printf "$2\n"
        ;;

        textList)
            printf "${YELLOW}==>${NC} $2\n"
        ;;

        textSep)
            printf "${NC}---------------------${NC}\n"
        ;;

        alertText)
            printf "${RED}$2${NC}\n"
        ;;

        alertSep)
            printf "${RED}---------------------${NC}\n"
        ;;

        noticeText)
            printf "${YELLOW}$2${NC}\n"
        ;;

        noticeSep)
            printf "${YELLOW}---------------------${NC}\n"
        ;;

        successText)
            printf "${GREEN}$2${NC}\n"
        ;;

        successSep)
            printf "${GREEN}---------------------${NC}\n"
        ;;
    *)
    esac
}

containsElement () {
    local e match="$1"
    shift
    for e; do [[ "$e" == "$match" ]] && return 0; done
    return 1
}

shellCommandRequired () {
    [ -z "$(command -v $1)" ] && {
        printText alertText "Error: $1 isn't installed"
        exit 1
    }
}

formatFilePath () {
    VAR_FORMAT_FILE_PATH__RESULT=$1
    VAR_FORMAT_FILE_PATH__RESULT=${VAR_FORMAT_FILE_PATH__RESULT//\/\//\/}
    echo $VAR_FORMAT_FILE_PATH__RESULT
}

# ===========================================
    # Implementation
# ===========================================

run () {
    checkForRequiredDependencies
    createTheToolDirectories

    parseArgs "$@"

    case "$VD_COMMAND" in
        create)
            actionCreate
        ;;

        delete)
            actionDelete
        ;;

        mount)
            actionMount
        ;;

        unmount | umount)
            actionUnmount
        ;;

        list)
            printText alertText "Not implemented yet"
            exit 1
        ;;

        fix)
            printText alertText "Not implemented yet"
            exit 1
        ;;
    *)
    esac
}

actionCreate () {
    validateVaultName "create"

    VD_VAULT_FILE_PATH=$(getVaultFilePath)
    if [ -f "$VD_VAULT_FILE_PATH" ]; then
        printText alertText "A virtual drive with name '${VD_VAULT_NAME}' already exists"
        printText alertText "Path:"
        printText alertText "  => $VD_VAULT_FILE_PATH"
        exit 1
    fi

    printText text "Creating a virtual drive. It might take a while..."
    dd if=/dev/urandom of=$VD_VAULT_FILE_PATH bs=1M count=512 status=progress

    printText text "Creating ext4 filesystem..."
    mkfs.ext4 -L $VD_VAULT_NAME $VD_VAULT_FILE_PATH

    if [[ "$VD_VAULT_IS_ENCRYPTED" = "y" ]]; then
        cryptsetup --verify-passphrase luksFormat $VD_VAULT_FILE_PATH
    fi

    chown $CURRENT_USER_ID:$CURRENT_USER_GROUP_ID $VD_VAULT_FILE_PATH

    printText text "Virtual drive has been sucessfully created"
    printText text "  ==> $VD_VAULT_FILE_PATH"

    if [[ "$VD_VAULT_MOUNT_AFTER_CREATE" = "y" ]]; then
        actionMount
    else
        printText nl
        printText text "Use the following command to mount it:"
        printText text "  ==> virtual-drive mount --name ${VD_VAULT_NAME}"
    fi
}

actionMount () {
    validateVaultName "mount"

    VD_VAULT_FILE_PATH=$(getVaultFilePath)
    if [ ! -f "$VD_VAULT_FILE_PATH" ]; then
        printText alertText "A virtual drive with name '${VD_VAULT_NAME}' doesn't exist"
        printText alertText "Path:"
        printText alertText "  => $VD_VAULT_FILE_PATH"
        exit 1
    fi

    MOUNT_DIR=$(getMountDir $VD_VAULT_NAME)
    BIND_DIR=$(getBindDir $VD_VAULT_NAME)

    printText text "Creating a mount directory..."
    printText text "  ==> $MOUNT_DIR"

    mkdir -p $MOUNT_DIR
    mkdir -p $BIND_DIR

    printText text "Mounting the virtual drive..."
    printText text "  ==> this directory is mounted as root user"
    printText text "  ==> $VD_VAULT_FILE_PATH"

    if [ $(isVaultFileEncrypted $VD_VAULT_FILE_PATH) ]; then
        cryptsetup open --type luks $VD_VAULT_FILE_PATH "vd_${VD_VAULT_NAME}"

        mount -t auto -o loop "/dev/mapper/vd_$VD_VAULT_NAME" $MOUNT_DIR
    else
        mount -t auto -o loop $VD_VAULT_FILE_PATH $MOUNT_DIR
    fi

    printText text "Binding the mounted directory with user permissions"
    printText text "  ==> this directory is mounted as the user running the script"
    printText text "  ==> $BIND_DIR"
    bindfs -u $CURRENT_USER_ID -g $CURRENT_USER_GROUP_ID $MOUNT_DIR $BIND_DIR

    printText text "To open the directory from the terminal"
    printText text "  ==> xdg-open $BIND_DIR"

    # if [[ "$VD_VAULT_OPEN_AFTER_MOUNT" = "y" ]]; then
        # if [ !-z $CURRENT_USER_NAME ]; then
        #    su - $CURRENT_USER_NAME
        #    xgd-open $BIND_DIR
        # fi
    # fi

    printText nl
    printText successText "$VD_VAULT_NAME has been mounted"
}

actionUnmount () {
    validateVaultName "unmount"

    VD_VAULT_FILE_PATH=$(getVaultFilePath)
    if [ ! -f "$VD_VAULT_FILE_PATH" ]; then
        printText alertText "A virtual drive with name '${VD_VAULT_NAME}' doesn't exist"
        printText alertText "Path:"
        printText alertText "  => $VD_VAULT_FILE_PATH"
        exit 1
    fi

    MOUNT_DIR=$(getMountDir $VD_VAULT_NAME)
    BIND_DIR=$(getBindDir $VD_VAULT_NAME)

    printText text "Unmounting $MOUNT_DIR"
    umount -l $MOUNT_DIR
    umount -f $MOUNT_DIR

    if [ $(isVaultFileEncrypted $VD_VAULT_FILE_PATH) ]; then
        printText text "Closing the encrypted virtual drive..."
        cryptsetup close "vd_${VD_VAULT_NAME}"
    fi

    printText text "Removing the mount directory"
    printText text "  ==> $MOUNT_DIR"
    rm -rf $MOUNT_DIR

    printText text "Removing the bind directory"
    printText text "  ==> $BIND_DIR"
    rm -rf $BIND_DIR

    printText nl
    printText successText "$VD_VAULT_NAME has been unmounted"
}

actionDelete () {
    printText noticeText "Deleting a virtual drive is permanent action"
    printText text "Do you want to proceed?"
    read -p "$* [y/n]: " yn
    case  $yn in
        [Nn]*)
            printText text "Aborted."
            exit 1
        ;;

        [Yy]*)
            printText text "Proceeding..."
            printText nl
        ;;
    *)
    esac

    actionUnmount
    printText nl

    validateVaultName "delete"

    VD_VAULT_FILE_PATH=$(getVaultFilePath)
    if [ ! -f "$VD_VAULT_FILE_PATH" ]; then
        printText alertText "A virtual drive with name '${VD_VAULT_NAME}' doesn't exist"
        printText alertText "Path:"
        printText alertText "  ==> $VD_VAULT_FILE_PATH"
        exit 1
    fi

    printText text "Deleting the virtual drive"
    printText text "  ==> $VD_VAULT_FILE_PATH"
    rm $VD_VAULT_FILE_PATH

    MOUNT_DIR=$(getMountDir $VD_VAULT_NAME)
    printText text "Removing the mount directory"
    printText text "  ==> $MOUNT_DIR"
    rm -rf $MOUNT_DIR

    BIND_DIR=$(getBindDir $VD_VAULT_NAME)
    printText text "Removing the bind directory"
    printText text "  ==> $BIND_DIR"
    rm -rf $BIND_DIR

    printText successText "$VD_VAULT_NAME has been deleted"
}

escalateScriptPrivilage () {
    if [ "${#}" = "0" ]; then
        printText alertText "virtual-drive: arguments missing"
        printText alertText "Try 'virtual-drive --help' for more information."
        printText nl
        exit 1
    fi

    if [ $EUID != 0 ]; then
        printText text "Working with virtual drives requires ${YELLOW}root${NC} permissions"
        printText text "The normal user accounts don't have rights to"
        printText text "  * ${YELLOW}mount${NC} filesystems"
        printText text "  * ${YELLOW}unmount${NC} filesystems"
        printText nl
        printText text "Please enter your ${YELLOW}root${NC} password to proceed"

        set -- "$@" --current-user-name $CURRENT_USER_NAME
        set -- "$@" --current-user-id $CURRENT_USER_ID
        set -- "$@" --current-user-group-id $CURRENT_USER_GROUP_ID
        set -- "$@" --current-user-directory $CURRENT_USER_HOME

        su - root  -- "$0" "$@"
        exit $?
    fi

    while [ "$#" -gt 0 ]; do
        case "$1" in
            --current-user-name)
                CURRENT_USER_NAME=$2
                shift
            ;;

            --current-user-id)
                CURRENT_USER_ID=$2
                shift
            ;;

            --current-user-group-id)
                CURRENT_USER_GROUP_ID=$2
                shift
            ;;

            --current-user-directory)
                CURRENT_USER_HOME=$2
                shift
            ;;
        *)
        esac

        shift
    done
}

isVaultFileEncrypted() {
    if [[ "$1" == *.encrypted.img ]]; then
        return 1
    else
        return 0
    fi
}

getMountDir () {
    VAR_GET_MOUNT_DIR="/mnt/$MNT_DIRECTORY_NAME/$1"
    echo $(formatFilePath $VAR_GET_MOUNT_DIR)
}

getBindDir () {
    VAR_GET_BIND_DIR="$(getVaultMountedDir)/$1"
    echo $(formatFilePath $VAR_GET_BIND_DIR)
}

getVaultDir () {
    VAR_GET_VAULT_DIR="${CURRENT_USER_HOME}/${WORKSPACE_DIRECTORY_NAME}"
    echo $(formatFilePath $VAR_GET_VAULT_DIR)
}

getVaultMountedDir () {
    VAR_GET_VAULT_MOUNTED_DIR="$(getVaultDir)/Mounted"
    echo $(formatFilePath $VAR_GET_VAULT_MOUNTED_DIR)
}

getVaultFileDir () {
    VAR_GET_VAULT_FILE_DIR="$(getVaultDir)/Vaults"
    echo $(formatFilePath $VAR_GET_VAULT_FILE_DIR)
}

getVaultFilePath () {
    VAR_GET_VAULT_FILE_PATH__RESULT=""

    VAR_GET_VAULT_FILE_PATH__BASE="$(getVaultFileDir)/${VD_VAULT_NAME}"
    VAR_GET_VAULT_FILE_PATH__BASE=$(formatFilePath $VAR_GET_VAULT_FILE_PATH__BASE)

    declare -a EXTENSIONS=(".img" ".encrypted.img")
    for i in "${EXTENSIONS[@]}"; do
        if [ -f "${VAR_GET_VAULT_FILE_PATH__BASE}${i}" ]; then
            VAR_GET_VAULT_FILE_PATH__RESULT="${VAR_GET_VAULT_FILE_PATH__BASE}${i}"
        fi
    done

    if [ -z $VAR_GET_VAULT_FILE_PATH__RESULT ]; then
        if [[ "$VD_VAULT_IS_ENCRYPTED" = "y" ]]; then
            VAR_GET_VAULT_FILE_PATH__RESULT="${VAR_GET_VAULT_FILE_PATH__BASE}.encrypted.img"
        else
            VAR_GET_VAULT_FILE_PATH__RESULT="${VAR_GET_VAULT_FILE_PATH__BASE}.img"
        fi
    fi

    echo $(formatFilePath $VAR_GET_VAULT_FILE_PATH__RESULT)
}

validateVaultName () {
    if [ -z "$VD_VAULT_NAME" ]; then
        printText alertText "You must specify the name of the virtual drive"
        printText alertText "Example:"
        printText alertText "  => virtual-drive $1 --name myVirtualDrive"
        exit 1
    fi
}

validateArgument () {
    CM_LIST=$1
    CM_ARG=$2

    if containsElement $CM_ARG_VALUE $CM_LIST; then
        printText alertText "The value '$CM_ARG_VALUE' for $CM_ARG should not match any of the available arguments!"
        exit 1
    fi
}

validateArgumentValue () {
    CM_LIST=$1
    CM_ARG=$2
    CM_ARG_VALUE=$2

    if containsElement $CM_ARG_VALUE $CM_LIST; then
        printText alertText "The value '$CM_ARG_VALUE' for $CM_ARG should not match any of the available arguments!"
        exit 1
    fi
}

checkForRequiredDependencies () {
    shellCommandRequired "dd"
    shellCommandRequired "mount"
    shellCommandRequired "bindfs"
    shellCommandRequired "cryptsetup"
}

createTheToolDirectories () {
    mkdir -p $(formatFilePath "$CURRENT_USER_HOME$WORKSPACE_DIRECTORY_NAME")
    mkdir -p $(formatFilePath "$CURRENT_USER_HOME$WORKSPACE_DIRECTORY_NAME/Vaults/")
    mkdir -p $(formatFilePath "$CURRENT_USER_HOME$WORKSPACE_DIRECTORY_NAME/Mounted/")

    chown -R $CURRENT_USER_ID:$CURRENT_USER_GROUP_ID $CURRENT_USER_HOME$WORKSPACE_DIRECTORY_NAME
}

parseArgs () {
    ALL_ARGS=("create" "mount" "unmount" "umount" "list" "fix")
    ALL_ARGS+=("--workspace" "--name" "--mount" "--open" "--encrypted" "--list-mounted")
    ALL_ARGS+=("-h" "--help" "help")
    ALL_ARGS+=("-v" "--version" "version")
    ALL_ARGS+=("--current-user-name" "--current-user-id" "--current-user-group-id" "--current-user-directory")

    while [ "$#" -gt 0 ]; do
        case "$1" in
            create | mount | unmount | umount | delete | list | fix)
                VD_COMMAND=$1
            ;;

            --name)
                validateArgumentValue "${ALL_ARGS[@]}" "$1" "$2"
                VD_VAULT_NAME=$2
                shift
            ;;

            --mount)
                VD_VAULT_MOUNT_AFTER_CREATE="y"
            ;;

            --open)
                VD_VAULT_OPEN_AFTER_MOUNT="y"
            ;;

            --encrypted)
                VD_VAULT_IS_ENCRYPTED="y"
            ;;

            --list-mounted)
                VD_VAULT_LIST="mounted"
            ;;

            -h | --help | help)
                printHelp
                exit 1
            ;;

            -v | --version | version)
                printText text $VERSION
                exit 1
            ;;

            --current-user-name)
                shift
            ;;

            --current-user-id)
                shift
            ;;

            --current-user-group-id)
                shift
            ;;

            --current-user-directory)
                shift
            ;;
        *)

        printText alertText "Error! Unknown option '$1'."
        printText nl
        printHelp
        exit 1
        esac

        shift
    done
}

# ===========================================
    # INIT
# ===========================================

clear
printCopyright
escalateScriptPrivilage "$@"

run "$@"
exit 1
