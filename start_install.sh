#!/usr/bin bash

cd  /tmp
wget https://raw.githubusercontent.com/thestinger/termite/master/termite.terminfo
tic -x termite.terminfo

apt-get install zsh

