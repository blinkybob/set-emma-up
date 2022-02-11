#!/usr/bin/env bash

# shell script
# local installation / new setup of laptop
# 18.01.2022

# to-do: farben reinbringen für den output, ganzes apt glump wegloggen
# nur relevanten output anzeigen
# ubuntu os codename etc. als variable für etcher input oder anderes zeug!!!

# Vars
DISTRO=ubuntu
CODENAME=impish
VERSION=21.10
#WORKDIR=/home/"$(whoami)"/
mkdir -p /home/"$(whoami)"/tools/

# Colors
RED="\e[31m"
GREEN="\e[32m"
EC="\e[0m"

# update system
echo -e "${GREEN}Updating OS...${EC}"
sudo apt-get update && sudo apt-get upgrade -y

# basic tools
echo -e "${GREEN}Installing basic tools...${EC}"
sudo apt-get install -y snapd flameshot kazam kvmtool virt-viewer virt-manager spice-client-gtk spice-html5 spice-webdavd \
    spice-vdagent remmina tmux zsh git openvpn network-manager-openvpn network-manager-openvpn-gnome \
    wireguard wireguard-dkms wireguard-tools firefox thunderbird filezilla \
    shotwell p7zip-full p7zip-rar bat unzip ncdu nextcloud-desktop

# install docker
sudo apt-get install -y docker.io docker-compose

# Download and install Postman
echo -e "${GREEN}Downloading and installing Postman...${EC}"
curl https://dl.pstmn.io/download/latest/linux64 -o postman-latest.tar.gz
tar -xf postman-latest.tar.gz -C /home/"$(whoami)"/tools/

# install webex Teams
# install MS Teams

# security tools
sudo apt-get install -y nikto hping3 wireshark tcpdump tshark nmap
sudo usermod -aG wireshark "$(whoami)"

# gnome extensions
sudo apt-get install -y gnome-shell-extensions
echo "not possible to install the extensions itself via CLI script"

# balena etcher
echo -e "${GREEN}Adding Etcher repo...${EC}"
curl -1sLf 'https://dl.cloudsmith.io/public/balena/etcher/setup.deb.sh' \
    distro=$DISTRO version=$VERSION codename=$CODENAME sudo -E bash

echo -e "${GREEN}Installing Etcher...${EC}"
sudo apt-get update && sudo apt-get install -y balena-etcher-electron

# Ulauncher
echo -e "${GREEN}Adding uLauncher repo and installing...${EC}"
sudo add-apt-repository -y ppa:agornostal/ulauncher
sudo apt-get update && sudo apt-get -y install ulauncher

# snaps

echo "Installing Snap Spotify ... "
sudo snap install spotify
echo "Installing snap VSCodium..."
sudo snap install codium --classic
echo "Installing snap telegram..."
sudo snap install telegram-desktop

# VSCodium Extensions ?

# Install Sublime text editor
echo -e "${GREEN}Adding Sublime Text repo and installing...${EC}"
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get install -y sublime-text

# Sublime Extensions

# install virtualbox

echo -e "${GREEN}Installing VirtualBox...${EC}"
sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian impish contrib" >> /etc/apt/sources.list.d/virtualbox.list'
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y virtualbox
sudo usermod -a -G vboxusers "$(whoami)"

# oh my zsh
echo "Installing Oh-My-Zsh..."

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo -e "\n...End of Oh-My-Zsh installation."

#timedatectl
sudo timedatectl set-timezone Europe/Berlin

# hostnamectl
sudo hostnamectl set-hostname emma
echo -e "${RED}HINT: change hostname in /etc/hosts manually${EC}"

#dotfiles

# Postman dotfile?

#tmux config files and plugins
sudo apt-get install -y tmux-plugin-manager

echo -e "${RED}HINT: Copying tmux dotfiles and plugin directory...${EC}"
cp files/.tmux.conf /home/"$(whoami)"/.tmux.conf
cp -r files/.tmux /home/"$(whomai)"/.tmux

echo -e "${GREEN}Installation ready...Press Y to reboot or N to reboot later!!!${EC}\n"
read -r input 

if [ "$input" == y ]
    then sudo reboot
else
    exit 0
fi