#!/bin/sh
#
# Copyright (c) Justin Pietsch
# All Rights Reserved
#
#necessary for suzieq
# python3.7 needs to be installed first
sudo apt install graphviz --assume-yes && \
sudo apt install graphviz-dev --assume-yes


git clone https://github.com/ddutt/suzieq.git
git clone https://github.com/ddutt/cyberpandas.git
pip3 install --user pipenv && \
export PATH=$PATH:$(pwd)/.local/bin && \
cd suzieq && \
rm -f Pipenv.lock && \
pipenv install && \
pipenv shell && \
cd ~/ && \
pip3 install ipython && \
cd cyberpandas && \
pip3 install .
exit
# still need to deal with the broken thing in one of the packages.
