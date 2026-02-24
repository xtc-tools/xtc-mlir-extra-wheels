#!/usr/bin/env bash
set -euo pipefail
set -x
dir="$(dirname "$(readlink -f "$0")")"

PYTHON="${PYTHON-python}"
INDEX_URL=https://pypi.org/simple
MLIR_VERSION=21.1.2.6

$PYTHON -m pip install \
        "xtc-mlir-tools==$MLIR_VERSION" \
        "xtc-mlir-dev==$MLIR_VERSION" \
        --index-url "$INDEX_URL"
