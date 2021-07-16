#!/bin/sh

install_vim() {
	# Installing vim-plug
	curl -sSfLo ~/.vim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

	# Hack to ignore errors while loading .vimrc
	printf %512s | tr ' ' '\n' | vim -c 'PlugInstall | qa!' >/dev/null 2>&1
}

install_nvim() {
	# Installing vim-plug
	curl -sSfLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	
	# Hack to ignore errors while loading .vimrc
	printf %512s | tr ' ' '\n' | nvim -c 'PlugInstall | qa!' >/dev/null 2>&1
}

alias cfggit='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
if [ ! -d $HOME/.cfg ] ; then
	echo Downloading...
	git clone --bare https://github.com/wojtek-kaniak/dotfiles.git $HOME/.cfg
	cfggit config --local status.showUntrackedFiles no
fi
cfggit checkout
if [ $? -ne 0 ]; then
	echo Fix errors and rerun this script
	exit 1
fi

echo Installing...

if command -v vim > /dev/null ; then
	install_vim
fi
if command -v nvim > /dev/null ; then
	install_nvim
fi

echo Done!
