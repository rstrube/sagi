#!/bin/bash

#|# PulseEffects + "Perfect EQ"
#|#./ingredients/media/pulseeffects.sh

sudo pacman -Syu --noconfirm --needed pulseeffects
mkdir -p ~/.config/PulseEffects/output
cp ./supporting/Perfect-EQ.json ~/.config/PulseEffects/output/