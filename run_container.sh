#!/bin/bash
MYHUBID=jccisneros
USER=$(whoami)
MYIMG=template
STATALIC="/Applications/Stata/stata.lic"
GITHUB_KEY="/Users/${USER}/.ssh" # Default SSH file name if following Github tutorial
DROPBOX="/Users/${USER}/Dropbox (GSLab)" # Change to Dropbox folder name

docker run -it --rm \
  --read-only -v "${STATALIC}":/usr/local/stata/stata.lic \
  --read-only -v "${DROPBOX}":/home/statauser/dropbox \
  --read-only -v "${GITHUB_KEY}":/home/statauser/.ssh \
  -v "$(pwd)":/home/statauser/template \
  -w /home/statauser/template \
  $MYHUBID/${MYIMG} -; echo "Container removed"