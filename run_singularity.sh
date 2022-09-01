#!/bin/bash
USER=$(whoami)
IMAGE_SIF=/home/groups/gentzkow/${USER}/simg/template_latest.sif
STATALIC="/share/software/user/restricted/stata/17/licenses/econ.lic"
GITHUB_KEY="home/users/${USER}/.ssh" # Default SSH file name if following Github tutorial
DROPBOX="/oak/stanford/groups/gentzkow/${USER}/Dropbox" # Change to Dropbox folder name

singularity shell  \
  --bind "${STATALIC}":/usr/local/stata/stata.lic \
  --bind "${DROPBOX}":/home/statauser/dropbox \
  --bind "${GITHUB_KEY}":/home/statauser/.ssh \
  --bind --writable "$(pwd)":/home/statauser/template \
  $IMAGE_SIF -; echo "Container removed"
