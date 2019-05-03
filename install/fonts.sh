set -euo pipefail

mkdir -p ~/.files/fonts
pushd ~/.files/fonts
wget https://github.com/powerline/fonts/archive/master.zip
unzip master.zip
pushd fonts-master
./install.sh
popd
rm -r fonts-master
popd
rm -r fonts
