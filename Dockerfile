# syntax=docker/dockerfile:1.2
FROM dataeditors/stata17:2022-07-19
# this runs your code 

# switch to root user to install packages
USER root
ARG DEBIAN_FRONTEND=noninteractive
RUN cd /home/statauser

############### install preliminaries
RUN apt-get update \
    && apt-get install tzdata --yes \
    && apt-get install wget --yes \
    && apt-get install software-properties-common --yes \
    && apt-get install curl --yes \
    && apt-get install git-lfs --yes \
    && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

############### install LyX
# instructions from https://wiki.lyx.org/LyX/LyXOnUbuntu
RUN add-apt-repository ppa:lyx-devel/release --yes \
    && apt-get update \
    && apt-get install lyx --yes \
    && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
############### install LyX

############### install Conda
# instructions from https://stackoverflow.com/questions/64090326/bash-script-to-install-conda-leads-to-conda-command-not-found-unless-i-run-b
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O conda.sh
COPY setup/conda_env.yaml conda_env.yaml
RUN ["/bin/bash", "conda.sh", "-b", "-p", "/home/statauser/miniconda3"]
RUN rm -f conda.sh
RUN /home/statauser/miniconda3/bin/conda init bash
############### install Conda

# https://conda-forge.org/docs/user/tipsandtricks.html
# Change channel priority setting to strict (this is robust to having Python and R dependencies simultaneously)
RUN /home/statauser/miniconda3/bin/conda config --set channel_priority strict

# https://stackoverflow.com/questions/20635472/using-the-run-instruction-in-a-dockerfile-with-source-does-not-work
RUN /home/statauser/miniconda3/bin/conda env create -f conda_env.yaml

ENV PATH "$PATH:/home/statauser/miniconda3/bin"

# Create directories and make sure root is owner
RUN mkdir ~/.ssh \
    && chown statauser:stata ~/.ssh 
RUN mkdir /home/statauser/dropbox \
    && chown statauser:stata /home/statauser/dropbox

# Create a folder to work in
RUN mkdir /home/statauser/template \
    && chown statauser:stata /home/statauser/template

RUN --mount=type=secret,id=statalic,dst=/Applications/Stata/stata.lic \
    /usr/local/stata/stata-mp do /code/setup.do

WORKDIR /home/statauser/template

USER statauser:stata

RUN conda init
RUN exec bash

# run the master file
ENTRYPOINT ["/bin/bash"]