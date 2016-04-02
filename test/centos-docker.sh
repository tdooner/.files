#!/bin/bash
set -exuo pipefail
cleanup() {
  docker-machine stop dotfiles
  docker-machine rm -f dotfiles
}
# trap cleanup EXIT

docker-machine create --driver virtualbox dotfiles
eval "$(docker-machine env dotfiles)"
container=$(docker run -d centos:centos7 sleep 1000)

docker exec $container useradd -m tom
docker exec $container yum install -y git
docker cp $(cd $(dirname $0)/..; pwd) $container:/home/tom/.files
docker exec -u tom $container bash -c "cd ~ && ./.files/install.sh"
