#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
B2D_CFG_DIR=$HOME/.boot2docker


clean() {
  type boot2docker >/dev/null 2>&1 && {
    # Remove current VM
    boot2docker stop
    boot2docker delete
  }

  # Remove Homebrew's formula
  brew remove docker boot2docker

  # Remove config directory
  rm -fr $B2D_CFG_DIR
}

setup() {
  # Install using Homebrew
  sudo brew update || return 1
  brew install docker boot2docker || return 1

  mkdir -p $B2D_CFG_DIR || return 1
  cp $SCRIPT_DIR/profile $B2D_CFG_DIR/ || return 1

  boot2docker init || return 1
  
  for i in {49000..49900}; do
    echo "Setting forwarding port: $i"
    VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port$i,tcp,,$i,,$i" || return 1
    VBoxManage modifyvm "boot2docker-vm" --natpf1 "udp-port$i,udp,,$i,,$i" || return 1
  done

  boot2docker up || return 1
}

check() {
  docker -H=tcp://127.0.0.1:4243 version
}

clean && setup && check
