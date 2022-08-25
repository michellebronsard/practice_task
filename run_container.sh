#!/bin/bash
MYHUBID=jccisneros
USER=$(whoami)
MYIMG=template
STATALIC="/Applications/Stata/stata.lic"
GITHUB_KEY="/Users/${USER}/.ssh" # Default SSH file name if following Github tutorial
DROPBOX="/Users/${USER}/Dropbox (GSLab)" # Change to Dropbox folder name


docker run -it --rm \
  -v "${STATALIC}":/usr/local/stata/stata.lic \
  -v "${DROPBOX}":/usr/dropbox \
  -v "${GITHUB_KEY}":/root/.ssh \
  -v "$(pwd)":/root/template \
  -w /root/template \
  $MYHUBID/${MYIMG} -; echo "Container removed"