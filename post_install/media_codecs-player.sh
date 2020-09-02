#!/bin/bash
# Media - Codecs and Player

source _common-functions.sh

# Install media codecs and vlc
sudo pacman -Syu --noconfirm --needed a52dec aribb24 faac faad2 flac jasper lame libdca libdv libdvbpsi libmad libmatroska libmpeg2 libtheora libvorbis libxv opus wavpack x264 xvidcore libdvdcss vlc
