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
