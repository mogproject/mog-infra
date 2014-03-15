#!/bin/bash
#
# boot2docker installtion script for Mac
#

SCRIPT_DIR=$(cd $(dirname $0); pwd)
B2D_CFG_DIR=$HOME/.boot2docker


init() {
  # This script can work in Mac OS X only
  [[ $(uname -s) == "Darwin" ]] || return 1
}

clean() {
  # Remove current VM
  type boot2docker >/dev/null 2>&1 && {
    boot2docker status && (boot2docker stop || return 1)
    boot2docker status | grep "not exist" || (boot2docker delete || return 1)
  }

  # Remove Homebrew's formula
  [[ -n $(brew ls --versions docker) ]] && (brew remove docker || return 1)
  [[ -n $(brew ls --versions boot2docker) ]] && (brew remove boot2docker || return 1)

  # Remove executables
  rm -f /usr/local/bin/docker /usr/local/bin/boot2docker || return 1

  # Remove config directory
  rm -fr $B2D_CFG_DIR || return 1
}

setup() {
  # Install using Homebrew
  echo "Updating Homebrew."
  sudo brew update || return 1
  sudo brew tap homebrew/binary || return 1
  brew install docker boot2docker || return 1

  mkdir -p $B2D_CFG_DIR || return 1
  cp $SCRIPT_DIR/profile $B2D_CFG_DIR/ || return 1

  # Create docker host VM
  boot2docker init || return 1

  # Port forwarding settings
  echo "Setting forwarding ports."
  for i in {49000..49900}; do
    if (( (i - 49000) % 90 == 0)); then
      printf "$(( (i - 49000) / 9))%%"
    elif (( (i - 49000) % 15 == 0)); then
      printf "."
    fi
    VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port$i,tcp,,$i,,$i" || return 1
    VBoxManage modifyvm "boot2docker-vm" --natpf1 "udp-port$i,udp,,$i,,$i" || return 1
  done
  echo

  boot2docker up || return 1
  sleep 5
}

check() {
  docker -H=tcp://127.0.0.1:4243 version || return 1

  echo
  echo "Congratulations!"
  echo "Your Docker seems to be all set."
  echo
}

case $1 in
  clean) init && clean;;
  install) init && setup && check;;
  "") init && clean && setup && check;;
  *) echo "Usage: $0 [{clean|install}]"; exit 1
esac
