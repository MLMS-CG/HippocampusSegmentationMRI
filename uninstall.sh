#!/bin/bash

# Remove the old GCC
sudo update-alternatives --remove gcc "${PWD}/gcc/xgcc"
sudo update-alternatives --remove g++ "${PWD}/gcc/xg++"

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 1
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-11 1
