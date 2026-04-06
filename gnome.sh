#!/bin/bash

echo "config theme"

gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface accent-color 'yellow'
WALLPAPER_PATH="file://$HOME/config-sway-gruvbox/asset/wallpapergnome.jpg"

echo "Configuration du fond d'écran Gruvbox..."

gsettings set org.gnome.desktop.background picture-uri "$WALLPAPER_PATH"
gsettings set org.gnome.desktop.background picture-uri-dark "$WALLPAPER_PATH"

gsettings set org.gnome.desktop.background picture-options 'zoom'

echo "Config Paramètre"
gsettings set org.gnome.desktop.peripherals.mouse accel-profile 'flat'
gsettings set org.gnome.desktop.peripherals.mouse speed 0.0
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll false
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
gsettings set org.gnome.desktop.wm.preferences audible-bell false


echo "Configuration Nautilus"
echo " - Vue liste et activation du mode tree"
gsettings set org.gnome.nautilus.preferences default-folder-viewer 'list-view'
gsettings set org.gnome.nautilus.list-view use-tree-view true
echo " - Désactivation de l ouverture du dossier lorsqu un élément est glissé dedans"
gsettings set org.gnome.nautilus.preferences open-folder-on-dnd-hover false
echo " - Activation du double clic"
gsettings set org.gnome.nautilus.preferences click-policy 'double'
echo " - Modification de l ordre de tri"
gsettings set org.gtk.Settings.FileChooser sort-directories-first true
gsettings set org.gtk.gtk4.Settings.FileChooser sort-directories-first true

echo "Installation des extensions GNOME..."
sudo dnf install -y \
    gnome-shell-extension-dash-to-dock \
    gnome-shell-extension-appindicator \
    gnome-shell-extension-gpaste


echo "Configuration des extensions..."
gdbus call --session --dest org.gnome.Shell --object-path /org/gnome/Shell --method org.gnome.Shell.Extensions.InstallRemoteExtension "''" > /dev/null 2>&1
sleep 5

gnome-extensions enable dash-to-dock@micxgx.gmail.com
gnome-extensions enable appindicatorsupport@rgcjonas.gmail.com
gnome-extensions enable gpaste@gnome-shell-extensions.gnome.org

gnome-extensions disable background-logo@fedorahosted.org


gsettings set org.gnome.shell.extensions.dash-to-dock dock-position "BOTTOM"
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
gsettings set org.gnome.shell.extensions.dash-to-dock autohide-in-fullscreen true 
gsettings set org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup true
