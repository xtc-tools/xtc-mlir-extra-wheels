#!/usr/bin/env bash
set -euo pipefail
set -x
dir="$(dirname "$(readlink -f "$0")")"

# dump env
env | sort

BUILD_DIR="${1-xtc-mlir/build}"
INSTALL_DIR="${2-$dir/mlir-extra-tools/install}"
INSTALL_DEV_DIR="${3-$dir/mlir-extra-dev/install}"

BUILD_LLVM_CCACHE="${BUILD_LLVM_CCACHE:-1}"
CCACHE_OPTS=""
[ "$BUILD_LLVM_CCACHE" != 1 ] || CCACHE_OPTS="-DCMAKE_C_COMPILER_LAUNCHER=ccache -DCMAKE_CXX_COMPILER_LAUNCHER=ccache"

LLVM_BUILD_TYPE=Release

MLIR_PREFIX=$(python -c 'import mlir; print(mlir.__path__[0])')
LLVM_PREFIX=$(python -c 'import llvm; print(llvm.__path__[0])')

rm -rf "$BUILD_DIR" "$INSTALL_DIR" "$INSTALL_DEV_DIR"
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

cmake \
    -DLLVM_DIR="$LLVM_PREFIX"/lib/cmake/llvm \
    -DMLIR_DIR="$MLIR_PREFIX"/lib/cmake/mlir \
    -DCMAKE_INSTALL_PREFIX="$INSTALL_DIR" \
    -DCMAKE_INSTALL_RPATH='$ORIGIN:$ORIGIN/../lib:$ORIGIN/../../llvm/lib' \
    -DCMAKE_BUILD_TYPE="$LLVM_BUILD_TYPE" \
    -DLLVM_ENABLE_ASSERTIONS=ON \
    -DLLVM_ENABLE_WARNINGS=OFF \
    -DLLVM_PARALLEL_LINK_JOBS=1 \
    -DXTC_MLIR_INCLUDE_TESTS=OFF \
    $CCACHE_OPTS \
    -Wno-dev \
    -Wno-deprecated \
    -G Ninja \
    ..

mkdir -p "$INSTALL_DEV_DIR"
mv "$INSTALL_DIR"/lib "$INSTALL_DEV_DIR"/
