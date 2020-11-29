#!/usr/bin bash

cd  /tmp
wget https://raw.githubusercontent.com/thestinger/termite/master/termite.terminfo
tic -x termite.terminfo

apt-get update
apt-get upgrade
apt-get install zsh
apt-get install git
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


