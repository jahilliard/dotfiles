#!/bin/bash

# Installing python basic tools
echo "Trying to install pip globally"
easy_install pip
easy_install pip3
pip3 install --upgrade pip
pip3 install neovim
echo "Installing virtualenv. From here we will install all the tools we need."
pip3 install virtualenv
virtualenv --python=/usr/local/bin/python3 env
source env/bin/activate
pip3 install -r requirements.txt
echo "All done!"

# Installing R basic tools
echo "Trying to install R libraries"
# RScript requirements.R
echo "libraries Intalled"

# Installing RVM and Rails
echo "installing rails"
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable --ruby

rvm get stable --auto-dotfiles
gem install bundler
gem install rails
