#!/bin/bash

# Get current dir (so run this script from anywhere)
export DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Update dotfiles itself first
[ -d "$DOTFILES_DIR/.git" ] && git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master && git submodule update --init --recursive

#hookup Bash profile (includes everything in runcom/sources
ln -sfv "$DOTFILES_DIR/runcom/.bash_profile" ~

echo "Attempting user-install of Node.JS"
chmod +x $DOTFILES_DIR/backgroundinst/node.sh
$DOTFILES_DIR/backgroundinst/node.sh &> $DOTFILES_DIR/backgroundinst/node.log &