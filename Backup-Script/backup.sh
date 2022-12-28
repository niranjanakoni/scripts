#!/bin/bash

#########################
# Author: K Niranjana
#
# Title: Backup to USB Drive
#
# Version: v1
#########################
set -e

# Configuration file
file=$1

if [ -z "$file" ]; then
	echo
	echo "Please enter the configuration file"
	echo "Example:"
	echo "# ./backup.sh <configuration_file>"
	echo
	exit 1
fi

# Checking the configuration file and exit if not found
if ! [ -f $file ]; then
	echo
	echo "Configuration file is not found. Exiting the script...."
	echo
	exit 1
fi

# Getting the folder and USB path from config.txt
FOLDERS=$(grep "^FOLDER" $file | awk -F ":" '{print $2}')
USB_PATH=$(grep "^USB_PATH" $file | awk -F ":" '{print $2}')

# Check for Backup folder
if ! [ -d ${FOLDERS} ]; then
	echo
	echo -e "\e[31mInvalid path\e[0m"
       	echo "Please enter correct path and try again."
	echo
       	exit 1
fi

# Check for USB Drive
if ! [ -d ${USB_PATH} ]; then
	echo
       	echo "USB Drive is not mounted. Please mount it and try again."
       	echo
	exit 1
fi

# Backup folders
TIMESTAMP=$(date +"%d.%m.%Y")
HOSTNAME=$(hostname)
FILENAME=$TIMESTAMP-$HOSTNAME
BACKUP_DIR="$USB_PATH/$FILENAME"
mkdir -p $BACKUP_DIR
cd $BACKUP_DIR

#Archiving backup folder to USB Drive
DIR=$( dirname "${FOLDERS}" )
BASE=$( basename "${FOLDERS}" )

tar -C $DIR -Pczf $BASE.tar.gz $BASE
echo
echo -e Backup is "\e[1;32m completed\e[0m."
echo -e You can check backup files under "\e[1;34m$USB_PATH/$FILENAME\e[0m"
echo
