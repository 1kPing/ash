#!/bin/dash

cd ~/foosh-dash

find . -maxdepth 1 -mindepth 1 -exec mv -f {} ~ \;

cd

sudo mv pacman.conf /etc

sudo pacman -Syu

git clone https://aur.archlinux.org/paru.git

cd paru

makepkg -si

cd

packages="discord blender btop eog fastfetch foot galculator gimp gnome-keyring gnome-themes-extra gtk-engine-murrine hyprland hyprlock hyprpaper hyprsunset libreoffice-fresh ly mako mpv nwg-look obs-studio pavucontrol pcmanfm-gtk3 pipewire-pulse prismlauncher qbittorrent rnote signal-desktop starship ttf-cascadia-code-nerd ttf-font-awesome ufw waybar wev wine-gecko wine-mono wofi xdg-desktop-portal-hyprland yazi alarm-clock-applet bibata-cursor-theme-bin chromium-snapshot-bin github-desktop-bin gruvbox-dark-icons-gtk hyprshot librewolf-bin theclicker"

for package in $packages; do
  paru -S --noconfirm "$package"
done

paru -S steam

paru -S amd-ucode

paru -S nvidia

paru -S nvidia-settings

xdg-settings set default-web-browser librewolf.desktop

cd graphite-gtk-theme

./install.sh --tweaks rimless black

cd

gsettings set org.gnome.desktop.interface gtk-theme 'Graphite-Dark'

gsettings set org.gnome.desktop.interface icon-theme 'gruvbox-dark-icons-gtk'

sudo systemctl enable ly

rm -rf .git

rm -r foosh-dash

rm -r graphite-gtk-theme

rm LICENSE

rm README.md

rm foo.sh

echo finished, reboot your computer
