#!/bin/bash


### Clean.
vagrant destroy --force

### Create VirtualBox image and boot.
vagrant up

### Print status.
vagrant status
