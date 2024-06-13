sudo pacman -Syu
# add nerdfonts for neovim and configure kitty

sudo pacman -S ccmake wireplumbler lxappearance nwg-look arc-gtk-theme adapta-gtk-theme breeze-gtk thunar adwaita-icon-theme arc-icon-theme ristretto

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
sudo pacman -S cpio meson hyprpaper waybar hypridle hyprlock

# enable packages
hyprpm update
hyprpm add https://github.com/hyprwm/hyprland-plugins

# zsh
sudo pacman -S zsh zsh-autosuggestions zsh-syntax-highlighting
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
mv .zshrc ~/
