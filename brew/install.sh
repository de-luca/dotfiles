#!/bin/sh
#
# Homebrew
#
# This installs brew and bundles from given Brewfile $1
# - personal
# - work

if test ! $(which brew); then
  echo "Installing brew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

brew update
brew bundle --file "$HOME/.dotfiles/brew/Brewfile.${1}"

exit 0