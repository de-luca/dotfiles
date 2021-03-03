#!/usr/bin/env bash

# Link .zshrc
rm -rf $HOME/.zshrc
ln -s $HOME/.dot/zsh/.zshrc $HOME/.zshrc

# Link .antigenrc
rm -rf $HOME/.antigenrc
ln -s $HOME/.dot/zsh/.antigenrc $HOME/.antigenrc
