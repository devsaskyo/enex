# eNeX
### eNcrypt eXecutables
## About
With eNeX, you can encrypt executable files while still keeping them executable.
<br>
The encrypted executables are password protected.
<br>
(password protection can be disabled when encrypting the executable.)
<br>
<br>
[How it works](#how-it-works)
<br>
[Install](#install)
<br>
[--help (How to use)](#--help)
<br>
[Customize!](#customize!)
<br>

### How it works
When you encrypt a file using eNeX, it adds a [header](resources/header.md) at the start of the encrypted file. This header will be executed instead of the encrypted data and will handle the decryption and execution of the file. This means that **you do NOT need eNeX to decrypt an eNeX-encrypted file**. Instead, all you need to do is execute the file, which will decrypt and execute itself.
<br>
The decrypted code is stored in a temporary file in the `/etc/enex/temp` directory. This file is removed after the code executes. If you want to add more features, you can easily customize the header. You can find a formatted header.md [HERE](DOCS/formatted-header.md).

## Install
To install eNeX, run this on your linux server/computer:
<br>
```bash
git clone https://github.com/devsaskyo/enex.git; cd enex; chmod +x installer.sh; sudo ./installer.sh
```

## --help
```plaintext
Usage: 'enex <file>'
Using enex with only the file parameter will require additional steps before the file is encrypted.
If you want to encrypt a file using a single command, this is the format:
'enex -p <file> -n/-g/<password> --replace/<filename>'
-p: parameter prefix (necessary for using parameters)
<file>: the file that will be encrypted
-n: password protection will NOT be used
-g: generates a random password
<password>: if you want to use your own password, put it here
--replace: the encrypted file will replace the original
<filename>: if you do NOT want to replace the original file, put the new filename here
```

## Customize!
You can find a lot of customizations and easy ways to make your own [HERE](DOCS/CUSTOMIZE.md)!

Made by 𝚂𝙰𝚂𝙺𝚈𝙾 :3
