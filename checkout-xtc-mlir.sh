#!/usr/bin/env bash
set -euo pipefail
set -x
dir="$(dirname "$(readlink -f "$0")")"

XTC_MLIR_REVISION="$(cat "$dir"/xtc_mlir_revision.txt)"

mkdir -p xtc-mlir
cd xtc-mlir
git init
git config --local user.email "CIBOT@noreply.com"
git config --local user.name "CI BOT"
git remote add origin https://gitlab.inria.fr/CORSE/xtc-mlir.git
git fetch --depth 1 origin "$XTC_MLIR_REVISION"
git reset --hard FETCH_HEAD

# Apply patches with git and reset to fetched revision
if [ -d "$dir"/patches ]; then
    for patch in "$dir"/patches/*.patch; do
        git am "$patch"
    done
fi
git reset FETCH_HEAD
