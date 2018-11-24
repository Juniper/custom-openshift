#!/bin/bash
dest=$1
yes | cp -rf $PWD/../files/ntp.yml $dest/roles/contrail_master/tasks/ntp.yml


