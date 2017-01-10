#!/bin/bash

# Fail on error
set -eu -o pipefail

# Create Rockfile
rock init

# Add each spec to Rockfile
for specFile in ../Specs/*.yaml; do
  rocket=$(basename $specFile .yaml)
  if [ "$rocket" != "empty" ]
  then
    echo "  - $rocket" >> Rockfile
  fi
done

# Use local repository as global spec
mkdir -p .rock/specs/
ln -s ../../../ .rock/specs/global
ROCK_PATH=./.rock rock install
