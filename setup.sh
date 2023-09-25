#!/bin/bash

# Make sure we have either curl or wget - you GOTTA have one
if [ -x "$(command -v curl)" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash

	# Install brew if we're OSX (which we probably are)
	if [[ $OSTYPE == 'darwin'* || $OSTYPE == 'linux-gnu'* ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi


# Assume that if we have wget then we have Brew, since I can't think of a reasonable time you don't
# have curl and you do have wget
elif [ -x "$(command -v wget)" ]; then
  wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
fi

cp .zshrc ~/.zshrc
cp .alias ~/.alias
cp .funcs ~/.funcs

# Install ripgrep
brew install ripgrep

# xcode tools is dumb - gotta do this first so we can have git
if [[ $OSTYPE == 'darwin'* ]]; then
	xcode-select --install
fi

if ! [ -x "$(command -v git)" ]; then
	echo "Can't set up nvim - can't find git executable"
fi

# Time to get NVIM
# TODO: Don't raw dog brew install here since we're trying to make this work for linux too
brew install nvim
mkdir -p $HOME/.config/nvim
git clone git@github.com:Zertsov/nvim.git ~/.config/nvim
