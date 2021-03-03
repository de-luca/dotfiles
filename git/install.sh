#!/usr/bin/env bash

# Link .gitconfig
rm -rf $HOME/.gitconfig
ln -s $HOME/.dot/git/.gitconfig $HOME/.gitconfig

echo "Git user.name?"
read -r git_config_user_name
git config --global user.name $git_config_user_name

echo "Git user.email?"
read -r git_config_user_email
git config --global user.email $git_config_user_email
