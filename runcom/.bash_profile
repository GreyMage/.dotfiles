# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin
PATH=$PATH:$HOME/local/bin
export PATH

# Source the addons in the dotfiles source dir.
for DOTFILE in `find ~/.dotfiles/runcom/source`
do
  [ -f "$DOTFILE" ] && source "$DOTFILE"
done

#IF WE'RE ON A COMMAND LINE (instead of SCP or something)
if [ -n "$PS1" ]; then
	# If tmux local or otherwise is installed, use that as default.
	if command -v tmux>/dev/null; then
	  [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux new-session -A -s main
	fi
fi
