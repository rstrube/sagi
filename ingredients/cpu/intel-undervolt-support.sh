#!/bin/bash

#|# # Utilities neccessary to undervolt Intel CPUs
#|#./ingredients/cpu/intel-undervolt-support.sh 

DIR=$(dirname "$0")
source $DIR/../_helper/_common-functions.sh

sudo pacman -Syu --noconfirm --needed msr-tools bc
