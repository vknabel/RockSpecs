#!/bin/bash

set -eu -o pipefail

rock init

for specFile in ../Specs/*.yaml; do
  rocket=$(basename $specFile .yaml)
  if [ "$rocket" != "empty" ]
  then
    echo "  - $rocket" >> Rockfile
  fi
done

mkdir -p .rock/specs/
ln -s ../../../ .rock/specs/global
ROCK_PATH=./.rock rock install
