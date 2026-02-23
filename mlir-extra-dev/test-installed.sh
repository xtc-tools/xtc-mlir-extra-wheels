#!/usr/bin/env bash
set -euo pipefail
set -x

PREFIX="$(python -c 'import mlir;print(mlir.__path__[0])')"
[ -f "$PREFIX/lib/libMLIRToCTranslation.a" ] || exit 1

echo "ALL TESTS PASSED"
