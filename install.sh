#!/bin/bash

sudo pacman -Syu
# add nerdfonts for neovim and configure kitty

# install yay
sudo pacman -S --needed base-devel git
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ~
rm -rf yay
yay -S wlogout
yay -S bibata-cursor-theme-bin
sudo pacman -S ccmake alacritty wireplumbler lxappearance nwg-look arc-gtk-theme adapta-gtk-theme breeze-gtk thunar adwaita-icon-theme arc-icon-theme ristretto

# notification daemon 
sudo pacman -S swaync

# clipboard
sudo pacman -S cliphist

# Hyprland Desktop Portal
pacman -S xdg-desktop-portal-hyprland

# authentication agent
sudo pacman -S polkit-kde-agent

# Qt Wayland Support 
sudo pacman -S qt5-wayland qt6-wayland

# hyprland plugins and packages
sudo pacman -S cpio meson hyprpaper hyprshot waybar hypridle hyprlock

# enable packages
hyprpm update
hyprpm add https://github.com/hyprwm/hyprland-plugins
hyprpm enable hyprexpo

# zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/TamCore/autoupdate-oh-my-zsh-plugins $ZSH_CUSTOM/plugins/autoupdate
git clone https://github.com/hlissner/zsh-autopair ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autopair
git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH_CUSTOM/plugins/zsh-vi-mode
