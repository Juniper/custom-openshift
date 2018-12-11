#!/bin/bash
dest=$1
yes | cp -rf  $PWD/../files/additional_config.yml $dest/playbooks/openshift-node/private/additional_config.yml


