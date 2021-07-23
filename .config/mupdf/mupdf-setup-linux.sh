#!/usr/bin/bash

wget https://www.mupdf.com/downloads/archive/mupdf-1.17.0-source.tar.xz
tar xf mupdf-1.18.0-source.tar.xz
cd mupdf-1.18.0-source
sudo apt install freeglut3-dev
make
sudo make prefix=/usr/local install
