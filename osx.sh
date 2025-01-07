#!/bin/bash

echo ""
echo ""
echo ""
echo "============"
echo "Accept Xcode commitments"
echo "============"
echo ""
echo ""
# Install Xcode command line tools
sudo xcodebuild -license accept
xcode-select --install

echo ""
echo ""
echo ""
echo "============"
echo "Install Homebrew "
echo "============"
echo ""
echo ""
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

export PATH=/opt/homebrew/bin:$PATH

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)


# Install more recent versions of some macOS tools.
echo ""
echo ""
echo ""
echo "============"
echo "Install Homebrew core libraries"
echo "============"
echo ""
echo ""
# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"
# cask install for Hombrew
brew install cask
# Install GnuPG to enable PGP-signing commits.
brew install gnupg
# Install xquart for R and Graphing
brew install Caskroom/cask/xquartz
# Install `wget` with IRI support.
brew install wget
# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed
# Install Bash 4.
brew install bash
brew install bash-completion@2
# Vim
brew install vim 
brew install nvim
# Python
brew install python
# other
brew install cmake
brew install grep
brew install openssh
brew install pyenv
brew install tree

brew install postgres
brew install postgresql
brew install unixodbc
brew install mysql

# used by git, install AFTER cmake / python
brew install libgit2

# Install other useful binaries.
brew install git
brew install git-lfs

# Install Applications
brew tap homebrew/cask

brew install java
brew install --cask r
brew install --cask --appdir=/Applications google-chrome
brew install --cask --appdir=/Applications spotify
brew install --cask --appdir=/Applications sublime-text
brew install --cask --appdir=/Applications iterm2
brew install --cask --appdir=/Applications rstudio
brew install --cask --appdir=/Applications 1password
brew install --cask --appdir=/Applications slack 
brew install --cask --appdir=/Applications zoom 
brew install --cask --appdir=/Applications airtable 
brew install --cask --appdir=/Applications notion
brew install --cask --appdir=/Applications loom
brew install --cask --appdir=/Applications superhuman
brew install --cask --appdir=/Applications visual-studio-code
brew install --cask --appdir=/Applications discord
brew install --cask --appdir=/Applications cron
brew install --cask --appdir=/Applications warp 
brew install --cask --appdir=/Applications tableplus
brew install --cask --appdir=/Applications sketch
brew install --cask --appdir=/Applications docker
brew install --cask --appdir=/Applications bartender

# Switch to using brew-installed bash as default shell
if ! fgrep -q "${BREW_PREFIX}/bin/bash" /etc/shells; then
  echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells;
  chsh -s "${BREW_PREFIX}/bin/bash";
fi;


# Remove outdated versions from the cellar.
brew cleanup

echo ""
echo ""
echo ""
echo "============"
echo "Setup Hammerspoon and other keyboard utilities"
echo "============"
echo ""
echo ""
# Install jasonrudolph keyboard for mapped keys 
git clone https://github.com/jasonrudolph/keyboard.git ~/.keyboard
cd ~/.keyboard
script/setup
cd ~/dotfiles

echo ""
echo ""
echo ""
echo "============"
echo "Modify Mac settings"
echo "============"
echo ""
echo ""
# create SS Folder
mkdir -p ~/Desktop/Screenshots
# create symlink for useful files like profile photos
ln -s ~/dotfiles/public/ ~/Desktop/
# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true
# Save screenshots to the Documents/Screenshots
defaults write com.apple.screencapture location ~/Desktop/Screenshots
# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"
# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
# Disable the sound effects on boot
sudo nvram SystemAudioVolume=""
#Show Path bar in Finder
defaults write com.apple.finder ShowPathbar -bool true
#Show Status bar in Finder
defaults write com.apple.finder ShowStatusBar -bool true

echo ""
echo ""
echo ""
echo "============"
echo "Creating ssh key and connecting gh"
echo "============"
echo ""
echo ""

mkdir ~/.ssh

SSH_CONFIG_FILE=~/.ssh/config
if [ ! -f "$SSH_CONFIG_FILE" ]; then
  echo "Host *.github.com " >> ~/.ssh/config
  echo "  AddKeysToAgent yes" &>> ~/.ssh/config 
  echo "  UseKeychain yes" &>> ~/.ssh/config  
  echo "  IdentityFile ~/.ssh/id_ed25519" &>> ~/.ssh/config
fi

SSH_FILE=~/.ssh/id_ed25519
if [ ! -f "$SSH_FILE" ]; then
  echo "=== Must create with password for automations to work ==="
  echo ""
  ssh-keygen -t ed25519 -C "justin.a.hilliard@gmail.com"

  eval "$(ssh-agent -s)"

  ssh-add ~/.ssh/id_ed25519

  gh auth login 
  gh auth refresh -h github.com -s admin:public_key
  gh ssh-key add ~/.ssh/id_ed25519.pub --title "Justin's Laptop $(date +"%m-%Y")"
fi

echo ""
echo ""
echo ""
echo "============"
echo "Setup node and other js utilities"
echo "============"
echo ""
echo ""
# install nvm and create dir
brew install nvm
mkdir ~/.nvm
nvm install-latest-npm
nvm install --lts
npm install --global yarn

echo ""
echo ""
echo ""
echo "============"
echo "Setup R"
echo "============"
echo ""
echo ""
Rscript -e "install.packages('tidyverse', repos = 'http://cran.us.r-project.org')"

echo ""
echo ""
echo ""
echo "============"
echo "Reminders"
echo "============"
echo ""
echo ""
echo "Don't forget to install https://cleanshot.com/"
echo "Don't forget to install https://apps.apple.com/us/app/paste-clipboard-history-manager/id967805235"
echo "Don't forget to install https://grain.com/app/signup"
echo "Don't forget to install https://rize.io/"
echo "Toggle => tap to click"
echo "Toggle => Automatically hid and show the dock"
