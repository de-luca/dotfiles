#!/usr/bin/env bash

gpg --list-signatures

echo "Which Key?"
read -r key_id
git config --global user.signingkey "${key_id}"

read -p "Make signing required? " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
fi

git config --global commit.gpgsign true
