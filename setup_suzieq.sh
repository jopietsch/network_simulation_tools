#necessary for suzieq
sudo apt install graphviz --assume-yes && \
sudo apt install graphviz-dev --assume-yes


git clone https://github.com/ddutt/suzieq.git

cd suzieq
rm *.lock
pipenv install
pipenv shell
pip3 install ipython
cd ~/
git clone https://github.com/ddutt/cyberpandas.git
cd cyberpandas
pip3 install --user .
