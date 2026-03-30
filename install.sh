#!/bin/bash

echo "Mise a jour ..."
sudo dnf update -y 

echo "Ajout RPM fusion ..."
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y


echo "Installation des paquets..."
sudo dnf install -y $(cat packages.txt)

flatpak install flathub app.zen_browser.zen
flatpak install flathub com.spotify.Client
flatpak install flathub md.obsidian.Obsidian

echo "Installation de JetBrains Mono Nerd Font..."

mkdir -p ~/.local/share/fonts

URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip"
curl -L $URL -o /tmp/JetBrainsMono.zip

sudo dnf install unzip -y
unzip -o /tmp/JetBrainsMono.zip -d ~/.local/share/fonts/JetBrainsMono

rm /tmp/JetBrainsMono.zip
fc-cache -fv

echo "install des dotfilles..."
mkdir -p ~/.config
cp -r kitty ~/.config/
cp -r fastfetch ~/.config 

cd ~/tmp 
git clone https://github.com/nexxooo/nvim.git
cp -r nvim ~/.config/ 


echo "changement de shell..."
sudo chsh -s $(which zsh) $USER
# Installation de Oh My Zsh sans lancer le shell immédiatement
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended




