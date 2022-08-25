#!/bin/bash
MYHUBID=jccisneros
WINDOWS_USER=$(/mnt/c/Windows/System32/cmd.exe /c 'echo %USERNAME%' | sed -e 's/\r//g')
MYIMG=template
STATALIC="/mnt/c/Program Files/Stata17/stata.lic"
DROPBOX="/mnt/c/Users/$WINDOWS_USER/Dropbox (GSLab)"
GITHUB="/mnt/c/Users/$WINDOWS_USER/.ssh"

docker run -it --rm --read-only -v "$(pwd)":/root/template \
    -v "${GITHUB}":/root/.ssh \
    -v "${STATALIC}":/usr/local/stata/stata.lic \
    -v "${DROPBOX}":/usr/dropbox \
    -w /root/template jccisneros/template -; echo "Container removed"