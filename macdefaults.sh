#!/bin/bash
set -euo pipefail

# Trackpad: Force feedback, old-school scrolling
defaults write com.apple.trackpad.forceClick -bool true
defaults write com.apple.springing.enabled -bool true

# Enable 3-finger dragging
# TODO: Debug this and figure out why it doesn't work.
# defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true

# Set a speedy key repeat interval
defaults write NSGlobalDomain InitialKeyRepeat -int 25
defaults write NSGlobalDomain KeyRepeat -int 2

# Iterm2: Use preferences from this repo
defaults write com.googlecode.iterm2 PrefsCustomFolder "$HOME/.files/iterm";
# Iterm2: "Save changes to folder when iTerm2 quits"
defaults write com.googlecode.iterm2 "NoSyncNeverRemindPrefsChangesLostForFile_selection" -bool false
