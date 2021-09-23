#!/bin/bash

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install nvm

cp .zshrc ~/.zshrc
cp .alias ~/.alias
cp .funcs ~/.funcs
