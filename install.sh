#!/bin/bash

#Global Variables
CONFIG=$(pwd)
BSPWM=$HOME/.config/bspwm
SXHKD=$HOME/.config/sxhkd
OS=""

#Determine the OS
TEMP=$(python -mplatform)
if [[ $TEMP == *"Ubuntu"* ]]
then
  OS="Ubuntu"
elif [[ $TEMP == *"Arch"* ]]
then
  OS="Arch"
fi

#Install packages
if [[ $OS == "Ubuntu" ]]
then
  sudo apt-get update
  sudo apt-get install build-essential git bash xcb libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev libasound2-dev libx11-xcb-dev libxcb-xtest0-dev
  #Programs used in scripts
  sudo apt-get install terminator dmenu feh
elif [[ $OS == "Arch" ]]
then
  sudo pacman -Syy
  sudo pacman -S git bash libxcb xcb-util xcb-util-wm xcb-util-keysyms alsa-libbase-devel xorg-xinit xorg-server xorg-server-common xorg-server-devel xorg-server-utils xorg-xinput
  #Programs used in scripts
  sudo pacman -S terminator dmenu feh
fi

#Update Submodules
git submodule init &&
git submodule update &&

# Install the programs
cd xdo && make && sudo make install && cd .. &&
cd bar && make && sudo make install && cd .. &&
cd sxhkd && make && sudo make install && cd .. &&
cd xtitle && make && sudo make install && cd .. &&
cd sutils && make && sudo make install && cd .. &&
cd bspwm && make && sudo make install && cd .. &&

#Create needed directories
mkdir -p $BSPWM &&
mkdir -p $SXHKD &&

#Create symlinks for bspwm config files/directories
cd $BSPWM &&
ln -s $CONFIG/bspwmrc . &&
ln -s $CONFIG/panel . &&
ln -s $CONFIG/panel_bar . &&
ln -s $CONFIG/panel_colors . &&

#Create symlinks for sxhkd config files/directories
cd $SXHKD &&
ln -s $CONFIG/sxhkdrc . &&

#Symlink wallpaper to Home Directory
cd $HOME &&
ln -s $CONFIG/.wallpaper.jpg . &&
cd $CONFIG &&

#Setup necessary variables
sudo echo export PANEL_FIFO="/tmp/panel-fifo" >> /etc/profile &&
sudo echo export PATH=$PATH:$HOME/.config/bspwm >> /etc/profile

#Allow logging in via bspwm
if [[ $OS == "Ubuntu" ]]
then
  sudo cp bspwm/contrib/freedesktop/bspwm.desktop /usr/share/xsessions/
elif [[ $OS == "Arch" ]]
then
  touch $HOME/.xinitrc
  echo 'exec bspwm' >> $HOME/.xinitrc
  echo "Check your .xinitrc to make sure it's setup properly"
fi
