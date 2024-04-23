#!/usr/bin/env bash

BREW_DIR=$HOME/.dotfiles/brew
PARTS=$BREW_DIR/parts
BASE=$BREW_DIR/Base.Brewfile
BREWFILE=$BREW_DIR/Brewfile

if test ! $(which brew); then
  echo "Installing brew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

cp $BASE $BREWFILE
echo "Provisioned base Brewfile"

while :
do
  read -p "Apply part to base Brewfile: " RESP
  if [ "$RESP" == "" ]; then break
  else
    echo "" >> $BREWFILE
    if [[ "$RESP" =~ ^https?://.* ]]; then
      curl -fsSL "$RESP" >> $BREWFILE
    else
      cat ${PARTS}/${RESP} >> $BREWFILE
    fi
    echo "" >> $BREWFILE
  fi
done

echo "Brewfile ready"

# brew update
# brew bundle --file "$HOME/.dotfiles/brew/Brewfile"
