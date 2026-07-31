#!/usr/bin/env bash
set -euo pipefail
set -x
dir="$(dirname "$(readlink -f "$0")")"

INDEX_URL=https://pypi.org/simple
MLIR_VERSION=22.1.8.2

python3 -m pip install \
        "xtc-mlir-tools==$MLIR_VERSION" \
        "xtc-mlir-dev==$MLIR_VERSION" \
        "xtc-mlir-python-bindings==$MLIR_VERSION" \
        "nanobind==2.13.0" \
        --index-url "$INDEX_URL"
