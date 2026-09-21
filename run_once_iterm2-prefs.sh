#!/bin/sh
# point iTerm2 at the chezmoi-managed prefs folder (Settings > General > Settings > custom folder)
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$HOME/.config/iterm2"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
