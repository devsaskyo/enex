#!/bin/bash


prefix="[eNeX-uninstall]"
if [ $EUID -ne 0 ]; then
  echo "$prefix superuser permissions are required to uninstall eNeX."
  exit 1
fi
rm -rf /etc/enex || echo "COULDN'T REMOVE DIRECTORY /etc/enex"
rm /usr/bin/enex || echo "COULDN'T REMOVE FILE /usr/bin/enex"
echo "$prefix eNeX uninstalled successfully."
rm -rf "$0" || echo "$prefix COUDLN'T REMOVE UNINSTALL SCRIPT, PLEASE REMOVE MANUALLY: rm /etc/enex-uninstall.sh"
exit
