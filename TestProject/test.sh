#!/bin/bash

rm -rf Rockfile .rock

# Fail on error
set -eu -o pipefail

# Create Rockfile
echo "name: TestProject
url: https://github.com/RockSpecs/TestProject
version: 0.1.0
dependencies:
" > Rockfile

# Add each spec to Rockfile
for specFile in ../Specs/*.yaml; do
  rocket=$(basename $specFile .yaml)
  if [ "$rocket" != "empty" ]
  then
    echo "- $rocket" >> Rockfile
  fi
done

# Use local repository as global spec
SWIFT_VERSION=$(swiftenv local) ROCK_PATH=./.rock rock install
