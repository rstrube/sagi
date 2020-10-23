#!/bin/bash
# CPU - Intel Undervolting Support

DIR=$(dirname "$0")
source $DIR/../_helper/_common-functions.sh

sudo pacman -Syu --noconfirm --needed msr-tools bc
