#!/bin/sh
# Mac Setup

# Xcode
xcode-select --install

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
brew doctor

# Cocoa Pods
brew install cocoapods

# Chrome
brew install --cask google-chrome

# VSCode
brew install --cask visual-studio-code
