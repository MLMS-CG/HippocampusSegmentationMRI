#!/bin/bash

# Bind all deprecated git protocol url to https protocol
git config --global url.https://github.com/.insteadOf git://github.com/

# Install build dependencies
sudo apt update
sudo apt install build-essential cmake flex
python3 -m pip install scikit-build

# Install old GCC 8.5.0
sudo update-alternatives --remove gcc "${PWD}/gcc/xgcc" 2> /dev/null
sudo update-alternatives --remove g++ "${PWD}/gcc/xg++" 2> /dev/null
rm -rf ./gcc-source ./gcc-build ./gcc

## Search for GCC source
git clone --depth 1 --branch releases/gcc-8.5.0 https://github.com/gcc-mirror/gcc.git gcc-source
cd ./gcc-source && ./contrib/download_prerequisites
unset C_INCLUDE_PATH CPLUS_INCLUDE_PATH CFLAGS CXXFLAGS
cd ../

## Build GCC
mkdir ./gcc-build && cd ./gcc-build
../gcc-source/configure \
    --prefix=/gcc \
    --enable-languages=c,c++ \
    --disable-libquadmath \
    --disable-libquadmath-support \
    --disable-werror \
    --disable-bootstrap \
    --enable-gold \
	--disable-multilib;

make -j4

make DESTDIR="${PWD}" install
mv ./gcc ../

sudo apt remove flex
sudo apt autoremove

cd ../

## Set old GCC
sudo update-alternatives --install /usr/bin/gcc gcc "${PWD}/gcc/xgcc" 1
sudo update-alternatives --install /usr/bin/g++ g++ "${PWD}/gcc/xg++" 1

sudo update-alternatives --set gcc "${PWD}/gcc/xgcc"
sudo update-alternatives --set g++ "${PWD}/gcc/xg++"
