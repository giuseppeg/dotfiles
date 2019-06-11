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
install_cask brave-browser

# Cloud
install_cask megasync

# Comms
install_cask skype
install_cask slack
install_cask moeditor
install_cask teamviewer
install_cask 1password

# Media
install_cask spotify
install_cask vlc

# Development
install_cask sublime-text
install_cask gitify
install_cask iterm2
install_cask virtualbox
install_cask docker

# Mac OS Enhancements
install_cask alfred
install_cask the-unarchiver
install_cask hyperswitch

# Other stuff
install_cask flux

brew cask cleanup
