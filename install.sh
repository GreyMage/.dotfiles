#!/bin/sh

# Get current dir (so run this script from anywhere)
export DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Update dotfiles itself first
[ -d "$DOTFILES_DIR/.git" ] && git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master

#hookup Bash profile (includes everything in runcom/sources
ln -sfv "$DOTFILES_DIR/runcom/.bash_profile" ~

#install local instance of node (should be included as a submodule
echo "Attempting user-install of Node.JS"
cd $DOTFILES_DIR/node/
./configure --prefix=~/.node
make
make install
