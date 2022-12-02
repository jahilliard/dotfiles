#!/bin/bash

export PATH=/opt/homebrew/bin:$PATH

sudo xcodebuild -license accept
# Install Xcode command line tools
xcode-select --install

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade



# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed
# Install Bash 4.
brew install bash
brew install bash-completion@2

# Switch to using brew-installed bash as default shell
if ! fgrep -q "${BREW_PREFIX}/bin/bash" /etc/shells; then
  echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells;
  chsh -s "${BREW_PREFIX}/bin/bash";
fi;

# Install `wget` with IRI support.
brew install wget

# Install xquart for R and Graphing
brew install Caskroom/cask/xquartz

# Install GnuPG to enable PGP-signing commits.
brew install gnupg

# Install more recent versions of some macOS tools.
brew install vim 
brew install python
brew install unixodbc
brew install nvim
brew install grep
brew install openssh
brew install pyenv
brew install fzf
brew install libgit2
brew install eibxml2
brew install tree
brew reinstall cask
brew install postgres
brew install reattach-to-user-namespace
brew install cmake
brew install apache-arrow
brew install postgresql
brew install mysql

# install nvm and create dir
brew install nvm
mkdir ~/.nvm
nvm install-latest-npm
nvm install --lts

npm install --global yarn


# Install other useful binaries.
brew install git
brew install git-lfs

# Install Applications
brew install --cask java

brew tap homebrew/cask

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


# Remove outdated versions from the cellar.
brew cleanup

# Install jasonrudolph keyboard for mapped keys 
git clone https://github.com/jasonrudolph/keyboard.git ~/.keyboard
cd ~/.keyboard
script/setup

cd ~/dotfiles

# create SS Folder
mkdir -p ~/Documents/Screenshots

# create symlink for useful files like profile photos
ln -s ~/dotfiles/public/ ~/Desktop/

# Modify Mac settings
echo "Tweaking Apple Settings"
# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true
# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true
# Save screenshots to the Documents/Screenshots
defaults write com.apple.screencapture location ~/Documents/Screenshots
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

echo "Don't forget to install https://cleanshot.com/"
echo "Don't forget to install https://apps.apple.com/us/app/paste-clipboard-history-manager/id967805235"
echo "Don't forget to install https://grain.com/app/signup"
echo "Don't forget to install https://rize.io/"
echo "Toggle tap to click"
