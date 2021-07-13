#!/usr/bin/bash
# Download and install atari ROMs in a virtual environment

mkdir -p content/ROM/
cd content
wget http://www.atarimania.com/roms/Roms.rar
unrar e Roms.rar ./ROM/
python -m atari_py.import_roms ./ROM/
