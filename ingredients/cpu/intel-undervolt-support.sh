#!/bin/bash
# CPU - Intel Undervolting Support

#|#./ingredients/intel-undervolt-support.sh # Utilities neccessary to undervolt Intel CPUs

DIR=$(dirname "$0")
source $DIR/../_helper/_common-functions.sh

sudo pacman -Syu --noconfirm --needed msr-tools bc
