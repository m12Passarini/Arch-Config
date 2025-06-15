#!/bin/bash

echo ""
echo "Installing packages..."
echo ""

sudo pacman -Syu --noconfirm
sudo pacman -S --needed - < packages/pkglist.txt

if ! command -v git  || ! command -v base-devel &> /dev/null; then
    sudo pacman -S --noconfirm git base-devel
fi

if ! command -v yay &> /dev/null; then
    git clone https://aur.archlinux.org/yay.git
    cd yay
    sudo makepkg -si --noconfirm
    cd - 
    yay -S --needed - < packages/aurlist.txt
    rm -rf yay
else 
    yay -S --needed - < packages/aurlist.txt
fi

cp -r .config ~/
cp -r .icons ~/
cp -r .bashrc ~/

echo ""
echo "Installation completed successfully! - Now you can type 'reboot'"
echo ""
