#!/bin/bash


prefix="[eNeX-uninstall]"
if [ $EUID -ne 0 ]; then
  echo "$prefix superuser permissions are required to uninstall eNeX."
  exit 1
fi
rm -rf /etc/enex || output="COULDN'T REMOVE DIRECTORY /etc/enex"
rm /usr/bin/enex || output="$output COULDN'T REMOVE FILE /usr/bin/enex"
if [[ "$output" == "" ]]; then
  echo "$prefix eNeX uninstalled successfully."
else
  echo "$prefix error: $output"
fi
rm -rf "$0" || echo "$prefix COUDLN'T REMOVE UNINSTALL SCRIPT, PLEASE REMOVE MANUALLY: rm /etc/enex-uninstall.sh"
exit
