# Hardcoded from vagrant/bootstrap.sh
#!/bin/bash
set -eu -o pipefail

# install build deps (sudo)
sudo add-apt-repository ppa:ethereum/ethereum
sudo apt-get update
sudo apt-get install -y build-essential unzip libdb-dev libleveldb-dev libsodium-dev zlib1g-dev libtinfo-dev solc sysvbanner wrk

# install constellation 0.3.2
wget -q https://github.com/jpmorganchase/constellation/releases/download/v0.3.2/constellation-0.3.2-ubuntu1604.tar.xz
tar xfJ constellation-0.3.2-ubuntu1604.tar.xz
sudo cp constellation-0.3.2-ubuntu1604/constellation-node /usr/local/bin && sudo chmod 0755 /usr/local/bin/constellation-node
rm -rf constellation-0.3.2-ubuntu1604*

# install golang 1.9.3
wget -q https://dl.google.com/go/go1.9.3.linux-amd64.tar.gz
tar xfz go1.9.3.linux-amd64.tar.gz
sudo mv go /usr/local/go
rm -f go1.9.3.linux-amd64.tar.gz
PATH=$PATH:/usr/local/go/bin
echo 'PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc

# make/install quorum (you can do this in a common directory)
git clone https://github.com/jpmorganchase/quorum.git
pushd quorum >/dev/null
git checkout tags/v2.0.1
make all
sudo cp build/bin/geth /usr/local/bin
sudo cp build/bin/bootnode /usr/local/bin
popd >/dev/null

# install Porosity
wget -q https://github.com/jpmorganchase/quorum/releases/download/v1.2.0/porosity
sudo mv porosity /usr/local/bin && sudo chmod 0755 /usr/local/bin/porosity




