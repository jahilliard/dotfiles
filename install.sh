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

PLATFORM="";
if [ "$(uname)" == "Darwin" ]; then
    PLATFORM="osx"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    PLATFORM="linux"
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
	PLATFORM="dos"
fi

if [ -z "$PLATFORM" ]; then
	echo "Unable to determine platform. Define explictly with PLATFORM=\"osx/linux/dos\" ./install.sh"
	exit 1
fi

# Commands that I don't know where to put yet...
mkdir -p bin
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

if [ "$PLATFORM" == "osx" ]; then
	# Install osx tweaks (and homebrew)
	cd osx && ./install.sh
	cd ..
fi

# Install tools directory
cd tools && ./install.sh
cd ..

# Finish setup
vim +PluginInstall +qall

# Create Symlinks for load files
ln -s ~/dotfiles/bash/bash_profile ~/.bash_profile
ln -s ~/dotfiles/vim/vimrc .vimrc
ln -s ~/dotfiles/nvim/init.vim ~/.config/nvim/init.vim
ln -s ~/dotfiles/git/.gitignore ~/.gitignore
ln -s ~/dotfiles/git/.gitconfig ~/.gitconfig
