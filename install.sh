#!/bin/sh

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
mkdir -p $HOME/.config/bspwm
mkdir -p $HOME/.config/sxhkd

#Create symlinks for bspwm config files/directories
ln -s bspwmrc $HOME/.config/bspwm/
ln -s panel $HOME/.config/bspwm/
ln -s panel_bar $HOME/.config/bspwm/
ln -s panel_colors $HOME/.config/bspwm/

#Create symlinks for sxhkd config files/directories
ln -s sxhkdrc $HOME/.config/sxhkd

#Setup necessary variables
sudo su -c "echo PANEL_FIFO="/tmp/panel-fifo" >> /etc/profile"
sudo su -c "echo PATH=$PATH:$HOME/.config/bspwm >> /etc/profile"
