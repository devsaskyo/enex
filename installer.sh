#!/bin/bash


header="[eNeX-installer]"
if [ $EUID -ne 0 ]; then
  echo "${header} superuser permissions are required to install eNeX."
  exit 1
fi
echo "${header} installation started..."
echo "${header} creating directories..."
mkdir /etc/enex || echo "couldn't create directory /etc/enex"
mkdir /etc/enex/temp || echo "couldn't create directory /etc/enex/temp"
chmod 600 /etc/enex/temp || echo "COULDN'T CHANGE PERMISSIONS OF /etc/enex/temp"
echo "${header} copying resource files..."
cp ./resources/header.md /etc/enex/header.md || echo "COOULDN'T COPY RESOURCE FILES"
cp ./resources/encrypt.md /etc/enex/encrypt.sh || echo "COULDN'T COPY RESOURCE FILES (2)"
echo "${header} creating the 'enex' command..."
chmod +x /etc/enex/encrypt.sh || echo "COULDN'T MAKE encrypt.sh EXECUTABLE"
touch /usr/bin/enex || echo "COULDN'T CREATE FILE /usr/bin/enex"
echo "#!/bin/bash" > /usr/bin/enex || echo "C20"
echo "/etc/enex/encrypt.sh \"\$@\"" >> /usr/bin/enex || echo "C21"
chmod +x /usr/bin/enex || echo "COULDN'T MAKE /usr/bin/enex EXECUTABLE"
echo "${header} copying uninstall script..."
cp ./resource/uninstall.md /etc/enex-uninstall.sh || echo "COULDN'T COPY RESOURCE FILES FOR UNINSTALL SCRIPT"
chmod +x /etc/enex-uninstall.sh || echo "COULDN'T MAKE /etc/enex/uninstall.sh EXECUTABLE"
echo "${header} eNeX installed successfully."
exit
