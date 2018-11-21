#!/bin/bash
dest=$1
yes | cp -rf $PWD/../files/openshift.docker.node.service $dest/roles/openshift_node/templates/openshift.docker.node.service


