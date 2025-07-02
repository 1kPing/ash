#!/bin/dash

trap 'exit 1' INT


echo "!! This script is meant for a fresh install of Arch Linux !!"
sleep 1
echo "!! Everything currently in ~ will be moved to /home/old~N !!"
sleep 1
echo "Hit enter to proceed..."
read answer
if [ "$answer" = "^C" ]; then
    exit 1
else
    echo "Backing up ~ to an available /home/old~N directory and moving files..."
    
    base_dir="/home/old~"
    target_dir="$base_dir"
    counter=2
    
    while [ -d "$target_dir" ]; do
        target_dir="${base_dir}${counter}"
        counter=$((counter + 1))
    done
    
    sudo mkdir "$target_dir"
    cd
    sudo find . -maxdepth 1 -mindepth 1 -exec mv -f {} "$target_dir" \;
    cd "$target_dir"/ash
    sudo find . -maxdepth 1 -mindepth 1 -exec mv -f {} ~ \;
    cd
    sudo rmdir "$target_dir"/ash
    sudo mkdir -p /usr/share/fonts/TTF
    sudo mv -f ~/TTF/* /usr/share/fonts/TTF
    rm -rf ~/.git
    rmdir ~/TTF
    rm ~/LICENSE
    rm ~/README.md
fi

sudo mv -f ~/pacman.conf /etc
sudo pacman -Syyu base linux linux-firmware base-devel grub efibootmgr networkmanager git rustup --noconfirm
rustup default stable
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si --noconfirm
cd

packages="linux-zen linux-zen-headers github-desktop-bin hyprshot librewolf-bin gtk-layer-shell libdbusmenu pipewire-alsa sof-firmware socat blender btop fastfetch foot galculator gamemode gimp gnome-themes-extra gtk-engine-murrine hyprland hyprlock hyprpaper hyprsunset imv libreoffice-fresh mako mangohud mpv neovim nwg-look pavucontrol pcmanfm-gtk3 pipewire-pulse prismlauncher qbittorrent sassc signal-desktop starship ttf-font-awesome ufw waybar wev wine-gecko wine-mono wofi xdg-desktop-portal-gtk xdg-desktop-portal-hyprland yazi zsh"

for package in $packages; do
    paru -S --noconfirm "$package"
done

sudo mv ~/binaries/* /usr/local/bin
rmdir ~/binaries

echo "Do you want to install flatpak? (y/n)"
read answer
if [ "$answer" = "y" ]; then
    sudo pacman -S flatpak --noconfirm
    echo "Do you want to install discord through flatpak? (y/n)"
        read answer
	if [ "$answer" = "y" ]; then
            flatpak install com.discordapp.Discord -y
        fi
    echo "Do you want to install ungoogled chromium through flatpak? (y/n)"
        read answer
        if [ "$answer" = "y" ]; then
            flatpak install io.github.ungoogled_software.ungoogled_chromium -y
        fi
    echo "Do you want to install zen browser through flatpak? (y/n)"
        read answer
        if [ "$answer" = "y" ]; then
            flatpak install app.zen_browser.zen -y
        fi
fi

xdg-settings set default-web-browser librewolf.desktop
xdg-mime default imv.desktop image/avif image/gif image/jpeg image/jpg image/png image/svg image/webp
xdg-mime default mpv.desktop audio/cue audio/m4a audio/mp3 audio/ogg audio/wav video/avi video/h264 video/h265 video/mkv video/mov video/mp4 video/mpeg video/mpg video/mpv video/ogv video/webm

sudo ~/graphite-gtk-theme/other/grub2/install.sh -b
~/graphite-gtk-theme/install.sh --tweaks rimless black
gsettings set org.gnome.desktop.interface gtk-theme 'Graphite-Dark'
gsettings set org.gnome.desktop.interface icon-theme 'Gruvbox-Plus-Dark'
rm -r ~/graphite-gtk-theme
sudo echo "QT_QPA_PLATFORMTHEME=gtk3" | sudo tee /etc/environment

echo "vm.swappiness = 1" | sudo tee /etc/sysctl.conf
sudo sysctl -p

sudo mv -f ~/grub /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

sudo pacman -S steam
sudo pacman -S amd-ucode
sudo pacman -S nvidia-dkms

rm ~/a.sh

Hyprland

