#!/bin/bash
USER=$(whoami)
IMAGE_SIF="/home/groups/gentzkow/${USER}/simg/template_latest.sif"
STATALIC="/share/software/user/restricted/stata/17/licenses/econ.lic"
GITHUB_KEY="home/users/${USER}/.ssh" # Default SSH file name if following Github tutorial
DROPBOX="/oak/stanford/groups/gentzkow/${USER}/Dropbox" # Change to Dropbox folder name

singularity shell --bind "${STATALIC}":/usr/local/stata/stata.lic,"${DROPBOX}":/home/statauser/dropbox,"${GITHUB_KEY}":/home/statauser/.ssh,"$(pwd)":/home/statauser/template /home/groups/gentzkow/jccp/simg/template_latest.sif
echo "Container removed"
