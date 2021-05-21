#!/bin/bash
#|#./ingredients/media/vlc-codecs.sh #VLC media player and codecs

# Install media codecs and vlc
paru -S --noconfirm --needed a52dec aribb24 faac faad2 flac jasper lame libdca libdv libdvbpsi libmad libmatroska libmpeg2 libtheora libvorbis libxv opus wavpack x264 xvidcore libdvdcss vlc
