#!/bin/bash
set -e

# dotfiles
./dots.sh

# homebrew
./brew.sh

# cask
./cask.sh

# node
./node.sh

# subl
./subl.sh

# macos settings
./macos.sh

mkdir -p ~/code
