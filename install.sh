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
	echo "Unable to determine platform. Define explictly with PLATFORM=\"osx/linux/dos\" ./install.sh"
	exit 1
fi

# Commands that I don't know where to put yet...
mkdir -p bin
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

chmod +x ~/dotfiles/osx/install.sh
chmod +x ~/dotfiles/tools/install.sh

if [ "$PLATFORM" == "osx" ]; then
	echo " ABOUT TO MAC"
	# Install osx tweaks (and homebrew)
	cd osx && ./install.sh
	cd ..
fi


# Install tools directory
cd tools && ./install.sh
cd ..

# Create Symlinks for load files
ln -s ~/dotfiles/bash/bash_profile ~/.bash_profile
ln -s ~/dotfiles/vim/vimrc ~/.vimrc
mkdir -p ~/.config/nvim/
ln -s ~/dotfiles/nvim/init.vim ~/.config/nvim/init.vim
ln -s ~/dotfiles/git/gitignore ~/.gitignore
ln -s ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf

# Finish setup

# Finish setup
vim +PluginInstall +qall

