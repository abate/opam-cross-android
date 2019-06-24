#!/bin/sh

PREFIX=$1
HOST=$(${PREFIX}gcc -dumpmachine)

echo "prefix: \"${PREFIX}\"" > conf-gcc-windows.config
echo "host: \"${HOST}\"" >> conf-gcc-windows.config
