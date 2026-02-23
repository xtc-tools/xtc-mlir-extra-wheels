#!/usr/bin/env bash
set -euo pipefail
set -x
dir="$(dirname "$(readlink -f "$0")")"

PYTHON="${PYTHON-python}"
INDEX_URL=https://test.pypi.org/simple
LLVM_VERSION=21.1.2.5rc1

$PYTHON -m pip install \
        "xtc-mlir-tools==$LLVM_VERSION" \
        "xtc-mlir-dev==$LLVM_VERSION" \
        --index-url "$INDEX_URL"
