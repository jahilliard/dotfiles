#!/bin/bash


# Install Xcode command line tools
xcode-select --install

# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

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
brew install fzf
brew install libgit2
brew install eibxml2
brew install tree

# Install other useful binaries.
brew install git
brew install git-lfs

# Install Applications
brew cask install java
brew cask install eclipse-jee
brew cask install java6

brew cask install --appdir=/Applications atom
brew cask install --appdir=/Applications firefox
brew cask install --appdir=/Applications google-chrome
brew cask install --appdir=/Applications spotify
brew cask install --appdir=/Applications sublime-text
brew cask install --appdir=/Applications virtualbox
brew cask install --appdir=/Applications vlc
brew cask install --appdir=/Applications dbeaver-community
brew cask install --appdir=/Applications textwrangler
brew cask install --appdir=/Applications sonos
brew cask install --appdir=/Applications iterm2
brew cask install --appdir=/Applications dash
brew cask install --appdir=/Applications rstudio
brew cask install --appdir=/Applications slack 

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
# Enable tap touch for trackpad
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
sudo defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
sudo defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
sudo defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
