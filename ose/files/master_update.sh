#!/bin/bash
dest=$1
yes | cp -rf $PWD/../files/master_main.yaml $dest/roles/openshift_master/defaults/main.yml


