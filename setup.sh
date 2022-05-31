#!/usr/bin/env bash

# shell script
# local installation / new setup of laptop
# 18.01.2022
# Installations where user input is needed are at the end of the script, to keep it running more or less without user interaction
# 28.04.2022 - lots of changes, 

# Usage hint: choose your distro, codename, etc. in the vars section
# to do: change repo to europe/german one !?


# Vars
DISTROBASE=ubuntu
#CODENAME=impish
CODENAME=jammy
#VERSION=21.10
VERSION=22.04
#WORKDIR=/home/"$(whoami)"/
mkdir -p /home/"$(whoami)"/tools

# List of gnome shell extensions
https://extensions.gnome.org/extension/3628/arcmenu/
https://extensions.gnome.org/extension/1401/bluetooth-quick-connect/
https://extensions.gnome.org/extension/3724/net-speed-simplified/
https://extensions.gnome.org/extension/905/refresh-wifi-connections/
https://extensions.gnome.org/extension/906/sound-output-device-chooser/

#To-Do:
# install https://github.com/brunelli/gnome-shell-extension-installer
# install the gonme extensions with its ID -> own file

# Colors
RED="\e[31m"
GREEN="\e[32m"
EC="\e[0m"

# update OS
echo -e "${GREEN}Updating OS...${EC}"
sudo apt-get update && sudo apt-get upgrade -y

#timedatectl
sudo timedatectl set-timezone Europe/Berlin

# set timeformat gnome interface
gsettings set org.gnome.desktop.interface clock-format '24h'

# hostnamectl
sudo hostnamectl set-hostname emma
echo -e "${RED}HINT: change hostname in /etc/hosts manually!${EC}"

# Installation basic tools
echo -e "${GREEN}Installing basic tools...${EC}"
sudo apt-get install -y snapd flameshot kazam kvmtool virt-viewer virt-manager spice-client-gtk spice-html5 spice-webdavd \
    spice-vdagent remmina tmux zsh git openvpn network-manager-openvpn network-manager-openvpn-gnome \
    wireguard wireguard-dkms wireguard-tools firefox thunderbird filezilla pinta \
    shotwell p7zip-full p7zip-rar bat unzip ncdu flatpak nextcloud-desktop 

# Installation docker
sudo apt-get install -y docker.io docker-compose

# Docker Conatiners
# testssl

# Download and installation Postman
echo -e "${GREEN}Downloading and installing Postman...${EC}"
curl https://dl.pstmn.io/download/latest/linux64 -o /home/"$(whoami)"/tools/postman-latest.tar.gz
tar -xf postman-latest.tar.gz -C /home/"$(whoami)"/tools/


# install webex Teams

if [ -d "/opt/Webex/" ]
then
    echo "${RED}Webex already installed.${EC}"
else
    echo -e "${GREEN}Downloading and installing Webex Teams...${EC}"
    wget 'https://binaries.webex.com/WebexDesktop-Ubuntu-Official-Package/Webex.deb' -O /home/"$(whoami)"/tools/set-emma-up/files/webex.deb
    sudo dpkg -i /home/"$(whoami)"/tools/set-emma-up/files/webex.deb
fi

# install MS Teams
#echo -e "${GREEN}Downloading and installing MS Teams...${EC}"


# sec tools
echo -e "${GREEN}Sec Tools...${EC}"
sudo apt-get install -y nikto hping3 wireshark tcpdump tshark nmap python3-scapy sslscan minicom sqlitebrowser tableplus
sudo usermod -aG wireshark "$(whoami)"

# gnome extensions
sudo apt-get install -y gnome-shell-extensions
echo "${RED}not possible to install the extensions via CLI script${EC}"

# balena etcher
# check balena installed

if [ -f "/opt/balenaEtcher/balena-etcher-electron" ]
then
    echo "${RED}Etcher already installed.${EC}"
else
    echo -e "${GREEN}Adding Etcher repo...${EC}"
    curl -1sLf 'https://dl.cloudsmith.io/public/balena/etcher/setup.deb.sh' | distro=$DISTROBASE version=$VERSION codename=$CODENAME sudo -E bash

    echo -e "${GREEN}Installing Etcher...${EC}"
    sudo apt-get update && sudo apt-get install -y balena-etcher-electron
fi

# WOE USB for creating windows boot stick in linux
#https://omgubuntu.co.uk/2017/06/create-bootable-windows-10-usb-ubuntu

if [ -f "/usr/bin/woeusb" ]
then
    echo "${RED}Woeusb already installed.${EC}"
else
    echo -e "${GREEN}Adding WoeUSB repo and installing...${EC}"
    sudo add-apt-repository ppa:tomtomtom/woeusb -y
    sudo apt update && sudo apt install woeusb-frontend-wxgtk -y
fi

# Ulauncher check and installation
if [ -f "/usr/bin/ulauncher" ]
then
    echo "${RED}Ulauncher already installed.${EC}"
else
    echo -e "${GREEN}Adding uLauncher repo and installing...${EC}"
    sudo add-apt-repository -y ppa:agornostal/ulauncher
    sudo apt-get update && sudo apt-get -y install ulauncher
fi

#threema desktop client
if [ -f "/usr/bin/threema" ]
then
    echo "${RED}Threema already installed.${EC}"
else
    echo -e "${GREEN}Downloading and installing Threema client...${EC}"
    wget https://releases.threema.ch/web-electron/v1/release/Threema-Latest.deb -O Threema-latest.deb
    dpkg -i Threema-latest.deb 
fi


# snaps

#echo -e "${GREEN}Installing Snap Spotify...${EC}"
#sudo snap install spotify
echo -e "${GREEN}Installing snap VSCodium...${EC}"
#sudo snap install codium --classic
#move codium to native installation
echo -e "${GREEN}Installing snap telegram...${EC}"
sudo snap install telegram-desktop

# VSCodium Extensions ?

# flatpaks
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo -y
# Gnome Extension Manager
flatpak install flathub com.mattjakeman.ExtensionManager -y
# Spotify
flatpak install flathub com.spotify.Client -y

# Install Sublime text editor
echo -e "${GREEN}Adding Sublime Text repo and installing...${EC}"
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get install -y sublime-text

# Sublime Extensions

# Virtualbox

echo -e "${GREEN}Installing VirtualBox...${EC}"
sudo sh -c 'echo "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian eoan contrib" >> /etc/apt/sources.list.d/virtualbox.list'
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
sudo apt-get update
sudo apt-get install --assume-yes virtualbox virtualbox-dkms virtualbox-ext-pack virtualbox-guest-utils
sudo usermod -a -G vboxusers "$(whoami)"

# oh my zsh
echo "Installing Oh-My-Zsh..."

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo -e "\n...End of Oh-My-Zsh installation."

# Download and installation OWASP ZAP
wget https://github.com/zaproxy/zaproxy/releases/download/v2.11.1/ZAP_2_11_1_unix.sh -O zap.sh && sudo bash zap.sh && remove zap.sh

#tmux config files and plugins
sudo apt-get install -y tmux-plugin-manager

#dotfiles

# tmux
echo -e "${RED}HINT: Copying tmux dotfiles and plugin directory...${EC}"
cp files/.tmux.conf /home/"$(whoami)"/
mkdir -p /home/"$(whoami)"/.tmux && cp -r files/.tmux/* /home/"$(whoami)"/.tmux/
# bash aliases
cp files/.bash_aliases /home/"$(whoami)"/

# ulauncher
cp -r files/ulauncher /home/"$(whoami)"/.config/

echo -e "${RED}Installation finished...Please reboot the system!!!${EC}\n"