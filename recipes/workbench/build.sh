#!/usr/bin/env bash

mkdir build
cd build

if [[ "$target_platform" == linux-* ]]; then
    export CXX_FLAGS="$CXX_FLAGS -lGL -lGLU"
fi

# Base CMake invocation
cmake_args=(
  $CMAKE_ARGS
  -GNinja
  -DCMAKE_BUILD_TYPE:STRING=Release
  -DCMAKE_INSTALL_PREFIX:STRING=$PREFIX
  -DCMAKE_CXX_FLAGS="$CXX_FLAGS"
)

# Only on macOS do we force policy ≥3.5
if [[ "$target_platform" == osx-64 ]]; then
  cmake_args+=( -DCMAKE_POLICY_VERSION:STRING=3.5 )
fi

# Now run CMake with our assembled args
cmake "${cmake_args[@]}" ../src

cmake --build .
cmake --install .
