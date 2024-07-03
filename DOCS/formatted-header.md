This is the formatted header.md file. Here, you can see exactly what the code is doing! You can also copy this code and customize it - then just replace the `/etc/enex/header.md` file with your customized file!
### Without comments:
```bash
#!/bin/bash
if ! command -v openssl >/dev/null 2>&1; then
  echo "OpenSSL is not installed. Please install it and try again."
  exit 1
fi
if [ ! -d "/etc/enex" ]; then
  mkdir /etc/enex || echo "error: could not create directory /etc/enex"
fi
if [ ! -d "/etc/enex/temp" ]; then
  mkdir /etc/enex/temp || echo "error: could not make directory /etc/enex/temp"
fi
filepath=$(realpath "$0")
fullcontent=$(cat $filepath)
content="${fullcontent#*\<content\>}"
content="${content%%\<\/content\>*}"
filename=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 100 | head -n 1)
temp_file="/etc/enex/temp/${filename}.XXXXXXXXX"
touch "$temp_file"
trap 'rm -f "$temp_file"' EXIT
chmod +x $temp_file
password="${fullcontent#*\<password\>}"
password="${password%%\<\/password\>*}"
if [[ "$password" == "" ]]; then
  echo -n "password: "
  read -s password
fi
content_file="/etc/enex/temp/content.${filename}.XXXXXXXX"
touch "$content_file"
echo "$content" > "$content_file"
openssl aes-256-cbc -a -d -salt -pbkdf2 -in "$content_file" -out "$temp_file" -pass pass:"$password" || echo "ERROR: DECRYPTION FAILED."
"$temp_file"
rm "$temp_file" || echo "ERROR: TEMPORARY FILE COULD NOT BE REMOVED. PLEASE REMOVE IT MANUALLY: rm -f ${temp_file}"
rm "$content_file" || echo "ERROR: TEMPORARY CONTENT FILE COULD NOT BE REMOVED. PLEASE REMOVE IT MANUALLY: rm -f ${content_file}"
exit
```
### With comments:
```bash
#!/bin/bash
#check if openssl is installed (required for the decryption)
if ! command -v openssl >/dev/null 2>&1; then
  echo "OpenSSL is not installed. Please install it and try again."
  exit 1
fi
#check if the /etc/enex directory exists, and if it doesn't, create one. (This makes sure that any eNeX-encrypted file can be decrypted without the use of eNeX)
if [ ! -d "/etc/enex" ]; then
  mkdir /etc/enex || echo "error: could not create directory /etc/enex"
fi
#same thing except for a different directory
if [ ! -d "/etc/enex/temp" ]; then
  mkdir /etc/enex/temp || echo "error: could not make directory /etc/enex/temp"
fi
#get the full file path of the encrypted file which has this header (the full path of itself)
filepath=$(realpath "$0")
#get the entire encrypted file (including this header) into a string
fullcontent=$(cat $filepath)
#get the encrypted content
content="${fullcontent#*\<content\>}"
content="${content%%\<\/content\>*}"
#create a random file name for the temporary file which will store the decrypted code
filename=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 100 | head -n 1)
temp_file="/etc/enex/temp/${filename}.XXXXXXXXX"
#create the temp file
touch "$temp_file"
#delete the temp file upon script exit
trap 'rm -f "$temp_file"' EXIT
#make the temp file executable
chmod +x $temp_file
#get the password from the encrypted file
password="${fullcontent#*\<password\>}"
password="${password%%\<\/password\>*}"
#if there isn't a password ask the user for it
if [[ "$password" == "" ]]; then
  echo -n "password: "
  read -s password
fi
#create a temp file to store the encrypted content
content_file="/etc/enex/temp/content.${filename}.XXXXXXXX"
touch "$content_file"
echo "$content" > "$content_file"
#decrypt the temp file with the encrypted content and output it into the first temp file
openssl aes-256-cbc -a -d -salt -pbkdf2 -in "$content_file" -out "$temp_file" -pass pass:"$password" || echo "ERROR: DECRYPTION FAILED."
#execute the temp file
"$temp_file"
#remove the temp file
rm "$temp_file" || echo "ERROR: TEMPORARY FILE COULD NOT BE REMOVED. PLEASE REMOVE IT MANUALLY: rm -f ${temp_file}"
#remove the temp file containing the encrypted content
rm "$content_file" || echo "ERROR: TEMPORARY CONTENT FILE COULD NOT BE REMOVED. PLEASE REMOVE IT MANUALLY: rm -f ${content_file}"
exit
```



