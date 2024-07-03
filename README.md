# eNeX
### eNcrypt eXecutables
## About
With eNeX, you can encrypt executable files while still keeping them executable.


### How it works
When you encrypt a file using eNeX, it adds a [header](resources/header.md) at the start of the encrypted file. This header will be executed instead of the encrypted data and will handle the decryption and execution of the file. This means that **you do NOT need eNeX to decrypt an eNeX-encrypted file**. Instead, all you need to do is execute the file, which will decrypt and execute itself.
<br>
The decrypted code is stored in a temporary file in the `/etc/enex/temp` directory. This file is removed after the code executes.

## Install
To install eNeX, run this on your linux server:
<br>
`git clone https://github.com/devsaskyo/enex.git; cd enex; chmod +x installer.sh; sudo ./installer.sh`
