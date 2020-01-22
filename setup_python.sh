#!/bin/sh
#
# Copyright (c) Justin Pietsch
# All Rights Reserved
#
# setup python3.7
sudo apt install python3.7 --assume-yes && \
sudo apt install python3.7-dev --assume-yes && \ 
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 1 && \
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 2 && \ 
sudo update-alternatives --config python3 --skip-auto && \
sudo apt install python3-pip --assume-yes && \
sudo apt install python3-apt --reinstall --assume-yes && \
#sudo apt remove python-pexpect python3-pexpect --assume-yes && \    
sudo pip3 install --upgrade pexpect && \
sudo apt install ipython3 --assume-yes 
