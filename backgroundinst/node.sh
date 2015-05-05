#!/bin/bash
#install local instance of node (should be included as a submodule
# exit on error
set -e

cd $DOTFILES_DIR/node/
./configure --prefix=$HOME/.node
make
make install
