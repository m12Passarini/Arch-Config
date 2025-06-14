#!/bin/bash

echo ""
echo "Installing packages..."
echo ""

sudo pacman -Syu --noconfirm
sudo pacman -S --needed - < packages/pkglist.txt

if ! command -v yay &> /dev/null; then
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd - 
    yay -S --needed - < packages/aurlist.txt
else 
    yay -S --needed - < packages/aurlist.txt
fi

cp -r .config ~/
cp -r .icons ~/
cp -r .bashrc ~/

echo ""
echo "Type - 'exit' and then 'reboot'"
echo ""
