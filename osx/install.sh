#!/usr/bin/env bash

# Install Xcode command line tools
xcode-select --install

# Install Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap caskroom/cask
brew tap caskroom/versions
brew tap homebrew/science

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
brew install gnu-sed --with-default-names
# Install Bash 4.
brew install bash
brew install bash-completion2

# Switch to using brew-installed bash as default shell
if ! fgrep -q "${BREW_PREFIX}/bin/bash" /etc/shells; then
  echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells;
  chsh -s "${BREW_PREFIX}/bin/bash";
fi;

# Install `wget` with IRI support.
brew install wget --with-iri

# Install xquart for R and Graphing
brew install Caskroom/cask/xquartz

# Install GnuPG to enable PGP-signing commits.
brew install gnupg

# Install more recent versions of some macOS tools.
brew install vim --with-override-system-vi
brew install nvim
brew install grep
brew install openssh
brew install pyenv
brew install r

# Install other useful binaries.
brew install git
brew install git-lfs

# Install Applications
brew cask install atom
brew cask install dropbox
brew cask install firefox
brew cask install google-chrome
brew cask install spotify
brew cask install sublime-text3
brew cask install virtualbox
brew cask install vlc
brew cask install dbeaver-community
brew cask install textwrangler
brew cask install sonos
brew cask install dash

# Remove outdated versions from the cellar.
brew cleanup

# Install jasonrudolph keyboard for mapped keys 
git clone https://github.com/jasonrudolph/keyboard.git ~/.keyboard
cd ~/.keyboard
script/setup
cd ~/dotfiles/osx

# Modify Mac settings
echo "Tweaking Apple Settings"
# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true
# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true
# Save screenshots to the desktop
defaults write com.apple.screencapture location -string “$HOME/Desktop”
# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string “png”
# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
# Disable the sound effects on boot
sudo nvram SystemAudioVolume=” “
#Show Path bar in Finder
defaults write com.apple.finder ShowPathbar -bool true
#Show Status bar in Finder
defaults write com.apple.finder ShowStatusBar -bool true
