#!/bin/sh
# Smoke test sestavených balíčků / binárek.
#   scripts/smoke.sh           – testuje commitnuté bundly (node asm80.js …)
#   scripts/smoke.sh <dir>     – testuje pkg binárky pro Linux v adresáři <dir> (např. dist)
set -eu

work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT
printf '\tORG 0\n\tNOP\n\tHLT\n' > "$work/smoke.a80"

if [ $# -eq 0 ]; then
  cd "$(dirname "$0")/.."
  node asm80.js "$work/smoke.a80"
  test -s "$work/smoke.hex"
  test -s "$work/smoke.lst"
  for util in asm80-link asm80-ar asm80-run; do
    node "$util.js" --help >/dev/null
  done
  echo "Smoke test bundlů: OK"
else
  dist="$1"
  for util in asm80 asm80-link asm80-ar asm80-run; do
    # pkg pojmenuje binárky např. asm80-linux-x64 nebo asm80-linux
    bin="$(ls "$dist/$util"-linux* 2>/dev/null | head -n 1)"
    if [ -z "$bin" ]; then
      echo "Chybí linuxová binárka pro $util v $dist" >&2
      exit 1
    fi
    chmod +x "$bin"
    if [ "$util" = asm80 ]; then
      "$bin" "$work/smoke.a80"
      test -s "$work/smoke.hex"
    else
      "$bin" --help >/dev/null
    fi
  done
  echo "Smoke test binárek: OK"
fi
