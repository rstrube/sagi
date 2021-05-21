#!/bin/bash
#|#./ingredients/core/pipewire.sh #Pipewire (replaces Pulseaudio)

paru -S pipewire pipewire-pulse xdg-desktop-portal xdg-desktop-portal-gtk
systemctl enable --user --now pipewire.service
systemctl enable --user --now pipewire-pulse.service
