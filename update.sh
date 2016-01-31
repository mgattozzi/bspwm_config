#!/bin/bash
set -euo pipefail

#Update Submodules
git submodule foreach git pull origin master

# Install the programs
cd xdo && make && sudo make install && cd ..
cd bar && make && sudo make install && cd ..
cd sxhkd && make && sudo make install && cd ..
cd xtitle && make && sudo make install && cd ..
cd sutils && make && sudo make install && cd ..
cd bspwm && make && sudo make install && cd ..
