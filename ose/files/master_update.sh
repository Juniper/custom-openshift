#!/bin/bash
dest=$1
yes | cp -rf $PWD/../files/master_main.yml $dest/roles/contrail_master/defaults/main.yml


