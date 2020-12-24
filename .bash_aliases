if grep -q Microsoft /proc/version; then
	alias winpy=python.exe
fi

alias ta='tmux attach -t'
alias status='systemctl status'

alias cfggit='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
