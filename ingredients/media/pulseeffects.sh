#!/bin/bash
#|#./ingredients/media/pulseeffects.sh #PulseEffects + Perfect EQ

paru -Syu --noconfirm --needed pulseeffects
mkdir -p ~/.config/PulseEffects/output
cp ./supporting/Perfect-EQ.json ~/.config/PulseEffects/output/