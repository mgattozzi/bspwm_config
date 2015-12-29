#!/bin/sh

#Global Variables
CONFIG=$(pwd)
BSPWM=$HOME/.config/bspwm
SXHKD=$HOME/.config/sxhkd

#Install necessary programs

#Update Submodules
git submodule init
git submodule update

#Install the programs
cd xdo && make && sudo make install && cd ..
cd bar && make && sudo make install && cd ..
cd sxhkd && make && sudo make install && cd ..
cd xtitle && make && sudo make install && cd ..
cd sutils && make && sudo make install && cd ..
cd bspwm && make && sudo make install && cd ..

#Create needed directories
mkdir -p $BSPWM
mkdir -p $SXHKD

#Create symlinks for bspwm config files/directories
cd $BSPWM
ln -s $CONFIG/bspwmrc .
ln -s $CONFIG/panel .
ln -s $CONFIG/panel_bar .
ln -s $CONFIG/panel_colors .

#Create symlinks for sxhkd config files/directories
cd $SXHKD
ln -s $CONFIG/sxhkdrc .

#Setup necessary variables
sudo su -c "echo PANEL_FIFO="/tmp/panel-fifo" >> /etc/profile"
sudo su -c "echo PATH=$PATH:$HOME/.config/bspwm >> /etc/profile"
