#!/bin/bash
#|#./ingredients/media/pulseeffects.sh #PulseEffects + Perfect EQ

sudo pacman -Syu --noconfirm --needed pulseeffects
mkdir -p ~/.config/PulseEffects/output
cp ./supporting/Perfect-EQ.json ~/.config/PulseEffects/output/