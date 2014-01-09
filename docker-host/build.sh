#!/bin/bash


### Clean.
vagrant destroy --force

### Install or update vagrant-vbguest plugin.
vagrant plugin install vagrant-vbguest

### Create VirtualBox image and boot.
vagrant up

### Print status.
vagrant status
