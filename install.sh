#!/bin/bash

PLATFORM="";
if [ "$(uname)" == "Darwin" ]; then
    PLATFORM="osx"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    PLATFORM="linux"
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
	PLATFORM="dos"
fi

if [ -z "$PLATFORM" ]; then
	echo "Unable to determine platform. Define PLATFORM=\"osx || linux || dos\""
	exit 1
fi

chmod +x ~/dotfiles/osx.sh

if [ "$PLATFORM" == "osx" ]; then
	echo ""
	echo ""
	echo ""
	echo "============"
	echo "Starting Mac Setup Script. "
	echo "============"
	echo ""
	echo ""
	./osx.sh
fi

# Create Symlinks for load files
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
ln -s ~/dotfiles/bash/bash_profile ~/.bash_profile
ln -s ~/dotfiles/vim/vimrc ~/.vimrc
mkdir -p ~/.config/nvim/
ln -s ~/dotfiles/nvim/init.vim ~/.config/nvim/init.vim
ln -s ~/dotfiles/git/gitignore ~/.gitignore
ln -s ~/dotfiles/git/gitconfig ~/.gitconfig

# Finish setup
vim +PluginInstall +qall