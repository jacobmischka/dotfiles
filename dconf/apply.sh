#!/usr/bin/env sh

dconf load /org/gnome/shell/keybindings/ < ~/.dotfiles/dconf/org.gnome.shell.keybindings
dconf load /org/gnome/desktop/keybindings/ < ~/.dotfiles/dconf/org.gnome.desktop.keybindings
dconf load /org/gnome/desktop/wm/keybindings/ < ~/.dotfiles/dconf/org.gnome.desktop.wm.keybindings
dconf load /org/gnome/settings-daemon/plugins/media-keys/ < ~/.dotfiles/dconf/org.gnome.settings-daemon.plugins.media-keys
dconf load /org/gnome/terminal/legacy/ < ~/.dotfiles/dconf/org.gnome.terminal.legacy
