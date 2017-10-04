#!/bin/bash

echo "dtparam=watchdog=on" >>/boot/config.txt

sed -i 's/#RuntimeWatchdogSec=0/RuntimeWatchdogSec=14/g' /etc/systemd/system.conf

if (whiptail --title "Watchdog Installation Script" --yesno "Installation completed! reboot required\n\nreboot now?" 12 60) then
    reboot
fi
