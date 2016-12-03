#!/usr/bin/env bash

DOTFILES_ROOT="$HOME/.dotfiles"

set -e
cp -R dots "$DOTFILES_ROOT"
dot_files=$(find "$DOTFILES_ROOT" -maxdepth 2 -name \*.symlink -print)

info () {
    printf "\r[ \033[00;34m..\033[0m ] $1\n"
}

link_files () {
    ln -s "$1" "$2"
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

	restart_shell
}

install_dotfiles
link_files "$DOTFILES_ROOT/.ssh" "$HOME/.ssh" 
