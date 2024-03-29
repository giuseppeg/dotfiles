#!/usr/bin/env bash

DOTFILES_ROOT="`pwd`/dots"

set -e
dot_files=$(find $DOTFILES_ROOT -maxdepth 1 -name \*.symlink -print)

info () {
    printf "\r[ \033[00;34m..\033[0m ] $1\n"
}

link_files () {
    ln -sf "$1" "$2"
    info "linked $1 to $2"
}

restart_shell () {
    exec "$(which $SHELL)"  -l
    info "enjoy!"
}

install_dotfiles () {
    info 'Installing dotfiles'

	for source in $dot_files; do
		file_base=$(basename "${source%.*}")
		dest="$HOME/.$file_base"
		if [ -h "$dest" ] && [ $(readlink "$dest") = $source ]; then
            		continue;
        	fi
		if [ -f "$dest" ] || [ -d "$dest" ]; then
			mkdir -p "$DOTFILES_ROOT/backup"
			mv "$dest" "$DOTFILES_ROOT/backup/$file_base"
		fi

		link_files "$source" "$dest"
	done
}


install_dotfiles

mkdir -p "$HOME/.ssh"
link_files "$DOTFILES_ROOT/.ssh/config.symlink" "$HOME/.ssh/config"

restart_shell
