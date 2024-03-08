#!/bin/bash

# Install build dependencies
sudo apt update
sudo apt install build-essential cmake

# Bind all deprecated git protocol url to https protocol
git config --global url.https://github.com/.insteadOf git://github.com/
