#!/bin/bash


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
