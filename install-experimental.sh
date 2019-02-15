#!/bin/bash

ERR='\033[0;31m'
INFO='\033[0;32m'
NC='\033[0m' # No Color

if [ $EUID -ne 0 ]; then
    echo -e "$ERR ERROR: This script should be run as root. $NC" 1>&2
    exit 1
fi

if (cat /etc/issue | grep -v Raspbian) then
    echo -e "$ERR ERROR: This script is only compatible with Raspbian Linux. $NC" 1>&2
    exit 1
fi

echo "dtparam=watchdog=on" >>/boot/config.txt

sed -i 's/#RuntimeWatchdogSec=0/RuntimeWatchdogSec=14/g' /etc/systemd/system.conf

if (whiptail --title "Watchdog Installation Script" --yesno "Installation completed! reboot required\n\nreboot now?" 12 60) then
    reboot
fi
