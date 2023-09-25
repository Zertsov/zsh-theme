#!/bin/bash

# Ensure the system has either curl or wget
if ! check_command_installed curl && ! check_command_installed wget; then
		echo "Error: This script requires either 'curl' or 'wget' to be installed."
		exit 1
fi

check_command_installed () { command -v "$1" &>/dev/null; }

log_install () {
	echo "[install]: $1"
}

if check_command_installed "curl"; then
		DLCMD="curl -fsSL"
else
		DLCMD="wget -qO-"
fi

install_nvm () {
	log_install "Installing NVM..."
	$DLCMD https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
}

install_brew () {
	log_install "Installing Homebrew..."
	bash -c "$($DLCMD https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

install_ripgrep () {
	log_install "Installing ripgrep..."
	brew install ripgrep
}

install_nvim () {
	log_install "Installing nvim..."
	brew install nvim
	mkdir -p $HOME/.config/nvim
	git clone git@github.com:Zertsov/nvim.git ~/.config/nvim
}

##############################################################
# Begin installs																					   #
# We assume Git is installed in all systems that aren't OSX. #
##############################################################

# OSX is dumb - gotta do this first so we can have git
if [[ $OSTYPE == 'darwin'* ]]; then
	xcode-select --install
fi

# Get nvm
if ! check_command_installed "nvm"; then
	install_nvm
fi

# Get brew
if ! check_command_installed "brew"; then
	install_brew
fi

# Get ripgrep
if ! check_command_installed "rg"; then
	install_ripgrep
fi

# Get NVIM
if ! check_command_installed "nvim"; then
	install_nvim
fi

# Override local dotfiles with our own
cp .zshrc ~/.zshrc
cp .alias ~/.alias
cp .funcs ~/.funcs

if ! [ -x "$(command -v git)" ]; then
	echo "Can't set up nvim - can't find git executable"
	exit 1
fi

