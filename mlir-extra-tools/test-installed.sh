#!/usr/bin/env bash
set -euo pipefail
set -x

PREFIX="$(python -c 'import mlir;print(mlir.__path__[0])')"
[ -f "$PREFIX"/runtime/include/xtc_crt/xtc_crt.h ] || exit 1

"$PREFIX"/bin/xtc-translate --version

echo "ALL TESTS PASSED"
