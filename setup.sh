#!/bin/bash

# Install cvmfs
wget -q https://ecsft.cern.ch/dist/cvmfs/cvmfs-release/cvmfs-release-latest_all.deb
sudo dpkg -i cvmfs-release-latest_all.deb
sudo apt-get -q update
sudo apt-get -q -y install cvmfs cvmfs-config-default
rm -f cvmfs-release-latest_all.deb

sudo mkdir -p /etc/cvmfs
sudo service autofs stop
sudo service autofs status
ls -al /etc/auto.cvmfs
ls -al /etc/auto.master.d/cvmfs.autofs
sudo echo "CVMFS_REPOSITORIES=eic.opensciencegrid.org" | sudo tee /etc/cvmfs/default.local
sudo cvmfs_config setup
sudo service autofs start
sudo service autofs status
ls -al /etc/auto.cvmfs
ls -al /etc/auto.master.d/cvmfs.autofs
#sudo mkdir -p /cvmfs/eic.opensciencegrid.org
#sudo mount -t cvmfs eic.opensciencegrid.org /cvmfs/eic.opensciencegrid.org

ls -al /cvmfs/eic.opensciencegrid.org
