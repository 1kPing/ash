# ash
## pre-installation
Do not run the script as root/sudo! Only use sudo when the script itself prompts you to.

Make sure you have dash installed to be able to run this.
```sh
sudo pacman -S dash
```
Make sure that the ```ash``` directory is cloned under the ```~``` directory, or bad stuff might happen.
## installation
To run the script:
```sh
~/ash/a.sh
```
---
### details of the created desktop

- hyprland

- bar and other widgets are done with eww

- no display manager (you'll need to open hyprland from the tty. my bashrc and zshrc come with the alias 'h' for hyprland, so you can use that to make opening it faster.)

- package list can be viewed in line 48 of ```a.sh```. note that paru, git, rustup, and base-devel are also installed

- you are responsible for installing the drivers and firmware for your own system

