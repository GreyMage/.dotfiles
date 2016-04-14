#!/bin/bash

# Get current dir (so run this script from anywhere)
export DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DOTFILES_DIR

# Make helper logger
function dfecho {
	echo -e "\n\e[1m[\e[92m$1\e[39m]\e[0m $2"
}

# Update dotfiles itself first

dfecho "DOTFILES" "Checking for updates"
[ -d "$DOTFILES_DIR/.git" ] && git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master && git submodule update --init --recursive

# Create local bin directory
mkdir -p $HOME/local/bin

#hookup Profile / Configs
dfecho "CONFIGS" "Linking"
ln -sfv "$DOTFILES_DIR/runcom/.bash_profile" ~
ln -sfv "$DOTFILES_DIR/runcom/.tmux.conf" ~
ln -sfv "$DOTFILES_DIR/runcom/.liquidpromptrc" ~

#hookup local binaries
dfecho "BINARIES" "Linking"
ln -sfv "$DOTFILES_DIR/node-v4.4.3-linux-x64/bin/node" "$HOME/local/bin/node"
ln -sfv "$DOTFILES_DIR/node-v4.4.3-linux-x64/bin/npm" "$HOME/local/bin/npm"

if ! command -v tmux > /dev/null; then
	dfecho "TMUX" "Attempting user-install"
	chmod +x $DOTFILES_DIR/noroottmux/tmux_local_install.sh
	$DOTFILES_DIR/noroottmux/tmux_local_install.sh
	if [ $? -eq 1 ]; then
		dfecho "TMUX" "Install failed"
	fi
else
	dfecho "TMUX" "Appears to already be installed. skipping."
fi

dfecho "DOTFILES" "Done!"
