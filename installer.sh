#!/bin/bash


header="[eNeX-installer]"
if [ $EUID -ne 0 ]; then
  echo "${header} superuser permissions are required to install eNeX."
  exit 1
fi

error() {
  local msg="$1"
  echo "${header} error: $msg"
  exit 1
}

echo "${header} installation started..."
echo "${header} creating directories..."
mkdir /etc/enex || error("couldn't create directory /etc/enex")
mkdir /etc/enex/temp || error("couldn't create directory /etc/enex/temp")
echo "${header} copying resource files..."
cp ./resources/header.md /etc/enex/header.md || error("COOULDN'T COPY RESOURCE FILES")
cp ./resources/encrypt.md /etc/enex/encrypt.sh || error("COULDN'T COPY RESOURCE FILES (2)")
echo "${header} creating the 'enex' command..."
chmod +x /etc/enex/encrypt.sh || error("COULDN'T MAKE encrypt.sh EXECUTABLE")
touch /usr/bin/enex || error("COULDN'T CREATE FILE /usr/bin/enex")
echo "#!/bin/bash" > /usr/bin/enex || error("C20")
echo "/etc/enex/encrypt.sh \"\$@\"" >> /usr/bin/enex || error("C21")
chmod +x /usr/bin/enex || error("COULDN'T MAKE /usr/bin/enex EXECUTABLE")
echo "${header} copying uninstall script..."
cp ./resource/uninstall.md /etc/enex-uninstall.sh || error("COULDN'T COPY RESOURCE FILES FOR UNINSTALL SCRIPT")
chmod +x /etc/enex-uninstall.sh || error("COULDN'T MAKE /etc/enex/uninstall.sh EXECUTABLE")
echo "${header} eNeX installed successfully."
exit
