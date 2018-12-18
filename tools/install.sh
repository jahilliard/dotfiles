#!/bin/bash

# Catch the sudo exception
if (($EUID != 0)); then
  if [[ -t 1 ]]; then
    sudo "$0" "$@"
  else
    exec 1>output_file
    gksu "$0 $@"
  fi
  exit
fi

# Installing python basic tools
echo "Trying to install pip globally"
easy_install pip
echo "Installing virtualenv. From here we will install all the tools we need."
pip install virtualenv
virtualenv  env
source env/bin/activate
pip install -r requirements.txt
echo "All done!"

# Installing R basic tools
echo "Trying to install R libraries"
RScript requirements.R
echo "libraries Intalled"
