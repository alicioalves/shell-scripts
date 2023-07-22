#! /usr/bin/bash

# Skip the GUI login screen
defaults write com.apple.loginwindow autoLoginUser -bool true

# massively increase virtualized macOS by disabling spotlight.
sudo mdutil -i off -a

# Enable performance mode
sudo nvram boot-args="serverperfmode=1 $(nvram boot-args 2>/dev/null | cut -f 2-)"

# Disable heavy login screen wallpaper
sudo defaults write /Library/Preferences/com.apple.loginwindow DesktopPicture ""

# Reduce Motion and Transparency
defaults write com.apple.Accessibility DifferentiateWithoutColor -int 1
defaults write com.apple.Accessibility ReduceMotionEnabled -int 1
defaults write com.apple.universalaccess reduceMotion -int 1
defaults write com.apple.universalaccess reduceTransparency -int 1
defaults write com.apple.Accessibility ReduceMotionEnabled -int 1

# Enable multi-sessions
sudo /usr/bin/defaults write .GlobalPreferences MultipleSessionsEnabled -bool TRUE

defaults write "Apple Global Domain" MultipleSessionsEnabled -bool true

# Disable updates
sudo su
defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticDownload -bool false
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool false
defaults write com.apple.commerce AutoUpdate -bool false
defaults write com.apple.commerce AutoUpdateRestartRequired -bool false
defaults write com.apple.SoftwareUpdate ConfigDataInstall -int 0
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 0
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 0
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 0

# Disable screen locking
defaults write com.apple.loginwindow DisableScreenLock -bool true

# Lighter username/password prompt
defaults write /Library/Preferences/com.apple.loginwindow.plist SHOWFULLNAME -bool true
defaults write com.apple.loginwindow AllowList -string '*'

# Disable application state save on shutdown
defaults write com.apple.loginwindow TALLogoutSavesState -bool false
