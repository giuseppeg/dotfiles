log() {
  local fmt="$1"; shift
  printf "\n\e[94m$fmt\n" "$@"
}

casks="$(brew cask list)"

install_cask() {
  if echo $casks | grep -w $1 > /dev/null 2>&1; then
    log "Already have %s installed. Skipping ..." "$1"
  else
    log "Installing %s ..." "$1"
    brew cask install "$@" 2> /dev/null
  fi
}

brew tap caskroom/cask
brew tap caskroom/versions

# Browsers
install_cask firefox
install_cask google-chrome
install_cask torbrowser

# Cloud
install_cask dropbox
install_cask megasync

# Comms
install_cask skype

# Media
install_cask spotify
install_cask vlc

# Development
install_cask sublime-text
install_cask gitify
install_cask iterm2
install_cask virtualbox

# Mac OS Enhancements
install_cask alfred
install_cask gpgtools
install_cask the-unarchiver
install_cask hyperswitch

# Other stuff
install_cask flux

brew cask cleanup
