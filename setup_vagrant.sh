#!/bin/sh
#
# Copyright (c) Justin Pietsch
# All Rights Reserved
#
# This updates Ubuntu 18.04 to use libvirt for vagrant so that we can do
# simulation of cloud native datacenter networking
# hints from:
#  https://github.com/ddutt/cloud-native-data-center-networking
#  https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#latest-releases-via-apt-debian
#  https://github.com/vagrant-libvirt/vagrant-libvirt#installation

sudo apt install cpu-checker --assume-yes && \
kvm-ok && \
sudo sh -c 'echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" >> /etc/apt/sources.list' && \
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367 && \
sudo apt update --assume-yes && \
sudo apt upgrade --assume-yes && \ 
sudo apt install vagrant --assume-yes && \
sudo apt install qemu-kvm --assume-yes && \
sudo apt install qemu libvirt-bin ebtables dnsmasq-base  --assume-yes && \
sudo apt install libxslt-dev libxml2-dev libvirt-dev zlib1g-dev ruby-dev --assume-yes && \
curl https://releases.hashicorp.com/vagrant/2.2.6/vagrant_2.2.6_x86_64.deb --output vagrant_2_2.6_x86_64.deb && \
sudo apt install ./vagrant_2_2.6_x86_64.deb  --assume-yes && \
sudo vagrant plugin install vagrant-libvirt  && \
sudo vagrant plugin expunge --reinstall --force && \
sudo apt install ansible --assume-yes && \

git clone https://github.com/ddutt/cloud-native-data-center-networking.git && \

sudo apt install emacs25-nox --assume-yes #why would you use VIM?
