set -euo pipefail

source $(dirname $0)/../util.sh

if [ $IS_IN_WSL = "true" ]; then
  echo "Skipping font install since we're in WSL."
else
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
fi
