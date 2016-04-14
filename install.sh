#!/bin/bash

# Get current dir (so run this script from anywhere)
export DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Update dotfiles itself first
[ -d "$DOTFILES_DIR/.git" ] && git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master && git submodule update --init --recursive

# Create local bin directory
mkdir -p $HOME/local/bin

#hookup Profile / Configs
ln -sfv "$DOTFILES_DIR/runcom/.bash_profile" ~
ln -sfv "$DOTFILES_DIR/runcom/.tmux.conf" ~
ln -sfv "$DOTFILES_DIR/runcom/.liquidpromptrc" ~

#hookup local binaries
ln -sfv "$DOTFILES_DIR/node-v4.4.3-linux-x64/bin/node" "$HOME/local/bin/node"
ln -sfv "$DOTFILES_DIR/node-v4.4.3-linux-x64/bin/npm" "$HOME/local/bin/npm"

echo "Attempting user-install of tmux"
chmod +x $DOTFILES_DIR/noroottmux/tmux_local_install.sh
$DOTFILES_DIR/noroottmux/tmux_local_install.sh &> $DOTFILES_DIR/noroottmux/tmux_local_install.log &
