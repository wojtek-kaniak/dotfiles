if grep -q Microsoft /proc/version; then
	alias winpy=python.exe
fi

alias cls=clear
alias ta='tmux attach -t'
alias status='systemctl status'
alias nv='nvim'

alias cfggit='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

mkcddir ()
{
	mkdir -p -- "$1" &&
		cd -P -- "$1"
}
