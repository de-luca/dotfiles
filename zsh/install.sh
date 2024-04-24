#!/usr/bin/env bash

# Link .zshrc
rm -rf $HOME/.zshrc
echo 'source $HOME/.dotfiles/zsh/.zshrc' > $HOME/.zshrc

# Link .antigenrc
rm -rf $HOME/.antigenrc
ln -s $HOME/.dotfiles/zsh/.antigenrc $HOME/.antigenrc
