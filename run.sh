#!/bin/bash

source /cvmfs/eic.opensciencegrid.org/packages/setup-env.sh
spack find

spack load eic@develop

root --version
