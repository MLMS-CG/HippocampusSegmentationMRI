#!/bin/bash

# Install build dependencies
sudo apt update
sudo apt install build-essential cmake

# Install old GCC 8.5.0
rm -rf ./gcc-source ./gcc-build ./gcc
git clone --depth 1 --branch releases/gcc-8.5.0 https://github.com/gcc-mirror/gcc.git gcc-source

cd ./gcc-source
./contrib/download_prerequisites

unset C_INCLUDE_PATH CPLUS_INCLUDE_PATH CFLAGS CXXFLAGS

mkdir ../gcc-build
cd ../gcc-build

../gcc-source/configure \
    --prefix=/usr/gcc-trunk \
    --enable-languages=c,c++ \
    --disable-libquadmath \
    --disable-libquadmath-support \
    --disable-werror \
    --disable-bootstrap \
    --enable-gold \
	--disable-multilib;

make -j4

mkdir ../gcc
make DESTDIR="../gcc" install

# Bind all deprecated git protocol url to https protocol
git config --global url.https://github.com/.insteadOf git://github.com/
