#! /bin/sh

FILE=hello && idris2 $FILE.idr -o $FILE && ./build/exec/$FILE