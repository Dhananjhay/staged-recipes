#!/usr/bin/env bash

set -e

mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
      ..
make

# copy binaries to $PREFIX/bin manually
mkdir -p $PREFIX/bin
cp src/scsnv $PREFIX/bin/
cp src/rfilter $PREFIX/bin/  # if needed

cd ../scsnvpy
$PYTHON -m pip install . \
    --no-deps \
    --ignore-installed \
    -vv