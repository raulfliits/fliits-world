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
# Versión portátil (consolas con Android y botones): solo el juego, sin la consola dibujada ni controles táctiles
mkdir -p juego/portatil
sed -e '1s#<html data-game-only="1">#<html data-game-only="1" data-frame="full" data-portatil="1">#' juego/index.html > juego/portatil/index.html
cp cw-icon-192.png cw-icon-512.png cw-icon-maskable-512.png cw-apple-touch-icon.png juego/portatil/
sed -e 's#"name": "FLiiTS Catalunya World · Juego"#"name": "FLiiTS World · Portátil"#' -e 's#"orientation": "any"#"orientation": "landscape"#' juego/catalunya-world.webmanifest > juego/portatil/catalunya-world.webmanifest
sed -e 's#"cwj-v1"#"cwp-v1"#' -e 's#"cwj-"#"cwp-"#' juego/cw-sw.js > juego/portatil/cw-sw.js
grep -q 'data-portatil="1"' juego/portatil/index.html && grep -q 'data-game-only="1"' juego/index.html && grep -q 'scope:"./"' juego/index.html && echo "ok"
