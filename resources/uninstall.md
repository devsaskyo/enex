#!/bin/bash


prefix="[eNeX-uninstall]"
if [ $EUID -ne 0 ]; then
  echo "$prefix superuser permissions are required to uninstall eNeX."
  exit 1
fi
error() {
  local msg="$1"
  echo "$prefix error: $msg"
  exit 1
}
rm -rf /etc/enex || error("COULDN'T REMOVE DIRECTORY /etc/enex")
rm /usr/bin/enex || error("COULDN'T REMOVE FILE /usr/bin/enex")
echo "$prefix eNeX uninstalled successfully."
rm -rf "$0" || echo "$prefix COUDLN'T REMOVE UNINSTALL SCRIPT, PLEASE REMOVE MANUALLY: rm /etc/enex-uninstall.sh"
exit
