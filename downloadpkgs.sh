#!/bin/bash

# installs homebrew if not found
if [ ! -x "$(command -v brew)" ]; then
  echo "Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# install library to read yaml if needed
if [ ! -x "$(command -v yq)" ]; then
    echo "yq not found. Installing..."
    brew install yq
fi

# install packages from yaml file
for pkg in $(yq '.packages[]' pkgs.yaml); do
    if [ ! -x "$(command -v $pkg)" ]; then
        echo "$pkg not found. Installing..."
        brew install $pkg
    fi
done