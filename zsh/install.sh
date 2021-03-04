#!/usr/bin/env bash

# Change shell to zsh
chsh -s /bin/zsh

# Link .zshrc
rm -rf $HOME/.zshrc
ln -s $HOME/.dotfiles/zsh/.zshrc $HOME/.zshrc

# Link .antigenrc
rm -rf $HOME/.antigenrc
ln -s $HOME/.dotfiles/zsh/.antigenrc $HOME/.antigenrc
