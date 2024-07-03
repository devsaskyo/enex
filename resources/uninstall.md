#!/bin/bash


header="[eNeX-uninstall]"
if [ $EUID -ne 0 ]; then
  echo "superuser permissions are required to uninstall eNeX."
  exit 1
fi
error() {
  local msg="$1"
  echo "$header error: $msg"
  exit 1
}
rm -rf /etc/enex || error("COULDN'T REMOVE DIRECTORY /etc/enex")
rm /usr/bin/enex || error("COULDN'T REMOVE FILE /usr/bin/enex")
echo "$header eNeX uninstalled successfully."
rm -rf "$0" || echo "COUDLN'T REMOVE UNINSTALL SCRIPT, PLEASE REMOVE MANUALLY: rm /etc/enex-uninstall.sh"
exit
