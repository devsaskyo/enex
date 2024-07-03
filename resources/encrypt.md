#!/bin/bash
                                                           
prefix="[eNeX] "
error=""                                                   jfile="$1"
if [[ "$jfile" == "" ]]; then
  echo -e "${prefix} usage: enex <file>\nhelp: enex --help"; exit 1                                                   fi                                                         if [[ "$jfile" == "--help" ]]; then
  echo -e "Usage: 'enex <file>'\nUsing enex with only the file parameter will require additional steps before the file is encrypted.\nIf you want to encrypt a file using a single command, this is the format:\n'enex -p <file> -n/-g/<password> --replace/<filename>'\n-p: parameter prefix (necessary for using parameters)\n<file>: the file that will be encrypted\n-n: password protection will NOT be used\n-g: generates a random password\n<password>: if you want to use your own password, put it here\n--replace: the encrypted file will replace the original\n<filename>: if you do NOT want to replace the original file, put the new filename here\nYou can find more information at:\nhttps://github.com/devsaskyo/enex"; exit
fi
if [[ "$jfile" == "-p" ]]; then
  usep="true"
fi
jfile="$2"
file=$(realpath $jfile)
if [ ! -f $file ]; then
  echo "${prefix} error: file '${file}' not found."; exit 1
fi
filename=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 100 | head -n 1)
temp_file="/etc/enex/temp/${filename}.XXXXXXXXX"
touch "$temp_file"
chmod +x "$temp_file"
trap 'rm -f "$temp_file"' EXIT
compoutput=""
if [[ "$usep" != "true" ]]; then
echo -n "${prefix} password protection? [Y/n]: "
read yorn
if [[ "$yorn" == "Y" ]] || [[ "$yorn" == "y" ]] || [[ "$yorn" == "Yes" ]] || [[ "$yorn" == "yes" ]]; then
  echo -n "${prefix} create a password (leave blank to generate one): "
  read password
  if [[ "$password" == "" ]]; then
    password=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 10 | head -n 1)
    echo -e "${header} password generated: ${password}\nCOPY IT, STORE IT IN A SAFE PLACE and then press enter to continue."
    read -s madebydevsaskyo
    clear
  fi
else
  echo "${prefix} password protection will NOT be used."
  password=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 50 | head -n 1)
  password="_${password}"
fi
else
  if [[ "$3" == "-n" ]]; then
    password=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 50 | head -n 1)
    password="_${password}"
  elif [[ "$3" == "-g" ]]; then
    password=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 10 | head -n 1)
    compoutput="password=${password}"
  elif [[ "$3" == "" ]]; then
    echo "${prefix} parameter error."; exit 1
  else
    password="$3"
  fi
fi
filecont=$(cat "$file")
outputenc=$(echo -n "$filecont" | openssl aes-256-cbc -a -e -salt -pbkdf2 -pass pass:"$password")
header=$(cat /etc/enex/header.md || error="${error}, cat_header_file_error")
if [[ "$error" != "" ]]; then
  echo "${prefix} CANNOT CONTINUE, ERROR: $error"; exit 1
fi
if [[ "$usep" != "true" ]]; then
echo -n "${prefix} do you want to replace the file '$file' with the encrypted file? [Y/n]: "
read yorn
if [[ "$yorn" == "Y" ]] || [[ "$yorn" == "y" ]] || [[ "$yorn" == "Yes" ]] || [[ "$yorn" == "yes" ]]; then
  encfile="$file"
else
  echo -n "${prefix} encrypted file name (full or relative path): "
  read encfile
fi
else
  if [[ "$4" == "--replace" ]]; then
    encfile="$file"
  elif [[ "$4" == "" ]]; then
    echo "${prefix} parameter error."; exit 1
  else
    encfile="$4"
  fi
fi
echo "$header" > $encfile
echo "<content>${outputenc}</content>" >> $encfile
if [[ "$password" == "_"* ]]; then
  echo "<password>${password}</password>" >> $encfile
else
  echo "<password></password>" >> $encfile
fi
echo "#this file is encrypted." >> $encfile
echo "#https://github.com/devsaskyo/enex" >> $encfile
chmod +x $encfile
rm $temp_file || echo "${header} ERROR: TEMPORARY FILE COULD NOT BE REMOVED, PLEASE REMOVE MANUALLY: rm -f $temp_file"
if [[ "$compoutput" != "" ]]; then
  echo "$compoutput"
fi
exit
