#!/bin/bash

# Install cvmfs
wget -q https://ecsft.cern.ch/dist/cvmfs/cvmfs-release/cvmfs-release-latest_all.deb
sudo dpkg -i cvmfs-release-latest_all.deb
sudo apt-get -q update
sudo apt-get -q -y install cvmfs cvmfs-config-default
rm -f cvmfs-release-latest_all.deb

# Restrict to eic.opensciencegrid.org
sudo mkdir -p /etc/cvmfs
echo "CVMFS_REPOSITORIES=eic.opensciencegrid.org" | sudo tee /etc/cvmfs/default.local
echo "CVMFS_HTTP_PROXY=DIRECT" | sudo tee -a /etc/cvmfs/default.local
sudo cvmfs_config setup
sudo cvmfs_config status
sudo cvmfs_config probe
sudo cvmfs_config showconfig

# Use autofs
echo "+dir:/etc/auto.master.d" | sudo tee /etc/auto.master
sudo mkdir -p /etc/auto.master.d
echo "/cvmfs /etc/auto.cvmfs" | sudo tee /etc/auto.master.d/cvmfs.autofs
sudo service autofs start
sudo service autofs status
ls -al /etc/auto.cvmfs
ls -al /etc/auto.master.d/cvmfs.autofs

sudo automount -m

ls -al /
ls -al /cvmfs
mount -t autofs
ls -al /cvmfs
ls -al /cvmfs/eic.opensciencegrid.org
