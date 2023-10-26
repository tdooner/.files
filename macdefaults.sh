#!/bin/bash
set -euo pipefail

# Trackpad: Force feedback, old-school scrolling
defaults write -g com.apple.trackpad.forceClick -bool true
defaults write -g com.apple.springing.enabled -bool true
defaults write -g com.apple.swipescrolldirection -int 0

# Trackpad: Enable 3-finger dragging
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true
defaults -currentHost write -g com.apple.trackpad.threeFingerDragGesture -bool true

# Keyboard: Set a speedy key repeat interval
defaults write NSGlobalDomain InitialKeyRepeat -int 25
defaults write NSGlobalDomain KeyRepeat -int 2

# Iterm2: Use preferences from this repo
defaults write com.googlecode.iterm2 PrefsCustomFolder "$HOME/.files/iterm";
# Iterm2: "Save changes to folder when iTerm2 quits"
defaults write com.googlecode.iterm2 "NoSyncNeverRemindPrefsChangesLostForFile_selection" -bool false

# Dock: Autohide
defaults write com.apple.dock autohide -int 1

# Screenshots: Not on the desktop
mkdir -p ~/Documents/Screenshots
defaults write com.apple.screencapture location "~/Documents/Screenshots"

# Menu Bar: "Show Bluetooth in menu bar"
defaults write com.apple.controlcenter "NSStatusItem Visible Bluetooth" -bool true

# TODO: Debug this and figure out why it doesn't work
# defaults write com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/Volume.menu"
# defaults write com.apple.systemuiserver -dict-add "NSStatusItem Visible com.apple.menuextra.volume" 1
# TODO: Find setting to disable "Look up and data detectors"

# Set Caps Lock -> Control
defaults -currentHost write -g com.apple.keyboard.modifiermapping.0-0-0 -dict HIDKeyboardModifierMappingDst 30064771300 HIDKeyboardModifierMappingSrc 30064771129
