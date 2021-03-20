#!/usr/bin/env bash

if test ! $(which brew); then
  echo "Installing brew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

brew update
brew bundle --file "$HOME/.dotfiles/brew/Brewfile"
