#!/bin/bash

sudo pacman -Syu --noconfirm

sudo pacman -S --needed - < pkglist.txt

if command -v yay &> /dev/null; then
    yay -S --needed - < aurlist.txt
elif command -v paru &> /dev/null; then
    paru -S --needed - < aurlist.txt
else
    echo "Install yay for packages in AUR"
fi

cp -r .config ~/

echo "Type - 'Reboot'"
