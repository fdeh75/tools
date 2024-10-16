#!/bin/bash

set -e

mkdir build-ovpn
cd build-ovpn
apt-get update
sudo apt-get install -y wget tar unzip build-essential libssl-dev iproute2 liblz4-dev liblzo2-dev libpam0g-dev libpkcs11-helper1-dev libsystemd-dev easy-rsa iptables pkg-config
sudo apt-get update
sudo apt-get install -y wget tar unzip build-essential libssl-dev iproute2 liblz4-dev liblzo2-dev libpam0g-dev libpkcs11-helper1-dev libsystemd-dev easy-rsa iptables pkg-config
sudo apt-get install -y wget tar unzip build-essential libssl-dev iproute2 liblz4-dev liblzo2-dev libpam0g-dev libpkcs11-helper1-dev libsystemd-dev easy-rsa iptables pkg-config
wget https://github.com/OpenVPN/openvpn/releases/download/v2.6.12/openvpn-2.6.12.tar.gz
tar xvf openvpn-2.6.12.tar.gz
cd openvpn-2.6.12
wget https://github.com/Tunnelblick/Tunnelblick/archive/refs/heads/master.zip
mv master.zip ..
cd ..
unzip master.zip
cp Tunnelblick-master/third_party/sources/openvpn/openvpn-2.6.12/patches/*.diff openvpn-2.6.12
cd openvpn-2.6.12
patch -p1 < 02-tunnelblick-openvpn_xorpatch-a.diff
patch -p1 < 03-tunnelblick-openvpn_xorpatch-b.diff
patch -p1 < 04-tunnelblick-openvpn_xorpatch-c.diff
patch -p1 < 05-tunnelblick-openvpn_xorpatch-d.diff
patch -p1 < 06-tunnelblick-openvpn_xorpatch-e.diff
sudo apt-get install libcap-ng-dev
./configure --disable-systemd --enable-async-push --enable-iproute2 --disable-dco
make
sudo make install

cd ../
git clone https://github.com/jonathanio/update-systemd-resolved.git
cd update-systemd-resolved
sudo make
sudo systemctl enable systemd-resolved.service
sudo systemctl start systemd-resolved.service
