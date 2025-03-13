#!/bin/bash

# Atualiza o sistema
sudo pacman -Syu --noconfirm

# Instala pacotes do repositório oficial
sudo pacman -S --needed - < pkglist.txt

# Instala pacotes do AUR (necessário ter o yay ou paru instalado)
if command -v yay &> /dev/null; then
    yay -S --needed - < aurlist.txt
elif command -v paru &> /dev/null; then
    paru -S --needed - < aurlist.txt
else
    echo "Instale yay ou paru para restaurar pacotes do AUR"
fi

# Restaurar configurações
cp -r .config ~/

echo "Configuração restaurada! Reinicie a sessão para aplicar as mudanças."

