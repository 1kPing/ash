#!/bin/dash

trap 'exit 1' INT

echo "!! Everything currently in ~ will be moved to /home/old~N !!"
sleep 1
echo "Hit enter to proceed..."
read answer
if [ "$answer" = "^C" ]; then
    exit 1
else
    echo "Backing up ~ to an available /home/old~N directory and moving configurations..."
    
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

sudo mv pacman.conf /etc
sudo pacman -Syu --needed base-devel git rustup --noconfirm
rustup default stable
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si --noconfirm
cd

packages="hyprshot librewolf-bin pipewire-alsa blender btop fastfetch foot galculator gimp gnome-keyring gnome-themes-extra gtk-engine-murrine hyprland hyprlock hyprpaper hyprsunset imv libreoffice-fresh ly mako mpv neovim nwg-look pavucontrol pipewire-pulse prismlauncher qbittorrent sassc signal-desktop starship ttf-font-awesome ufw waybar wev wine-gecko wine-mono wofi xdg-desktop-portal-hyprland yazi zsh"

for package in $packages; do
    paru -S --noconfirm "$package"
done

bash -c "$(curl -fsSL https://raw.githubusercontent.com/kontr0x/github-desktop-install/main/installGitHubDesktop.sh)"
sudo mv ~/binaries/* /usr/local/bin
rmdir ~/binaries

echo "Do you want to install flatpak? (y/n)"
read answer
if [ "$answer" = "y" ]; then
    sudo pacman -S flatpak --noconfirm
    echo "Do you want to install discord through flatpak? (y/n)"
        read answer
	if [ "$answer" = "y" ]; then
            sudo flatpak install com.discordapp.Discord -y
        fi
    echo "Do you want to install ungoogled chromium through flatpak? (y/n)"
        read answer
        if [ "$answer" = "y" ]; then
            flatpak install io.github.ungoogled_software.ungoogled_chromium -y
        fi
fi

sudo pacman -S steam
sudo pacman -S amd-ucode
sudo pacman -S nvidia

xdg-settings set default-web-browser librewolf.desktop
xdg-mime default imv.desktop image/*
xdg-mime default mpv.desktop video/*

sudo ~/graphite-gtk-theme/other/grub2/install.sh -b
~/graphite-gtk-theme/install.sh --tweaks rimless black
gsettings set org.gnome.desktop.interface gtk-theme 'Graphite-Dark'
gsettings set org.gnome.desktop.interface icon-theme 'gruvbox-dark-icons-gtk'
sudo echo "QT_QPA_PLATFORMTHEME=gtk3" | sudo tee -a /etc/environment

sudo mkdir -p /etc/alsa/conf.d
sudo ln -s /usr/share/alsa/alsa.conf.d/50-pipewire.conf /etc/alsa/conf.d
sudo ln -s /usr/share/alsa/alsa.conf.d/99-pipewire-default.conf /etc/alsa/conf.d
echo "autospawn = no" | sudo tee /etc/pulse/client.conf

rm -r ~/graphite-gtk-theme

echo "arch linux + ly + hyprland: setup successful"

echo "finished, reboot your computer"

sudo systemctl enable ly

rm ~/a.sh

exit 0

