#!/bin/sh
# Genera las dos versiones publicadas a partir del archivo del proyecto:
#   index.html        → presentación + juego (con la cuenta atrás)
#   juego/index.html  → solo el juego (sin los paneles de datos), al que lleva el QR
# Uso: sh build.sh ruta/a/FLiiTS_Catalunya_World.html
set -e
SRC="$1"; cd "$(dirname "$0")"
sed 's#navigator.serviceWorker.register("cw-sw.js",{scope:"./FLiiTS_Catalunya_World.html"})#navigator.serviceWorker.register("cw-sw.js",{scope:"./"})#' "$SRC" > index.html
mkdir -p juego
sed -e '1s#<!doctype html><html>#<!doctype html><html data-game-only="1">#' \
    -e 's#<title>FLiiTS Catalunya World</title>#<title>FLiiTS Catalunya World · Juego</title>#' index.html > juego/index.html
cp cw-icon-192.png cw-icon-512.png cw-icon-maskable-512.png cw-apple-touch-icon.png juego/
sed -e 's#"name": "FLiiTS Catalunya World"#"name": "FLiiTS Catalunya World · Juego"#' -e 's#"description": "Juego y presentación de FLiiTS Catalunya"#"description": "El juego de FLiiTS Catalunya"#' catalunya-world.webmanifest > juego/catalunya-world.webmanifest
sed -e 's#const CACHE = "cw-v2";#const CACHE = "cwj-v1";#' -e 's#k.startsWith("cw-")#k.startsWith("cwj-")#' cw-sw.js > juego/cw-sw.js
grep -q 'data-game-only="1"' juego/index.html && grep -q 'scope:"./"' juego/index.html && echo "ok"
