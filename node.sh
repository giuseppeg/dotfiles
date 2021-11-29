log() {
  local fmt="$1"; shift
  printf "\n\e[94m$fmt\n" "$@"
}

node_install_version=16.13.0

log "Installing nvm ..."
if [ ! -s "$NVM_DIR/nvm.sh" ] ; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | zsh
  source "$HOME/.nvm/nvm.sh"
  log "Installing node $node_install_version ..."
  nvm install "$node_install_version"
  nvm use "$node_install_version"
  nvm alias default node
else
  log "nvm already installed ..."
fi

log "Configuring npm to work without sudo..."
curl -o- https://raw.githubusercontent.com/glenpike/npm-g_nosudo/master/npm-g-nosudo.sh | zsh

npm_packages="$(npm list -g --depth=0)"
install_global_npm_package() {
  if echo $npm_packages | grep $1@ > /dev/null 2>&1; then
    log "Already have %s installed. Skipping ..." "$1"
  else
    log "Installing %s ..." "$1"
    npm i -g "$@" --quiet
  fi
}

log "Installing npm global packages ..."

install_global_npm_package yarn
install_global_npm_package diff-so-fancy
install_global_npm_package serve
install_global_npm_package vercel
install_global_npm_package replace
