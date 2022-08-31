#!/bin/bash
MYHUBID=jccisneros
WINDOWS_USER=$(/mnt/c/Windows/System32/cmd.exe /c 'echo %USERNAME%' | sed -e 's/\r//g')
MYIMG=template
STATALIC="/mnt/c/Program Files/Stata17/stata.lic"
DROPBOX="/mnt/c/Users/$WINDOWS_USER/Dropbox (GSLab)"
GITHUB="/mnt/c/Users/$WINDOWS_USER/.ssh"

docker run -it --rm \
  --read-only -v "${STATALIC}":/usr/local/stata/stata.lic:ro \
  --read-only -v "${DROPBOX}":/home/statauser/dropbox:ro \
  --read-only -v "${GITHUB_KEY}":/home/statauser/.ssh:ro \
  -v "$(pwd)":/home/statauser/template \
  -w /home/statauser/template \
  $MYHUBID/${MYIMG} -; echo "Container removed"