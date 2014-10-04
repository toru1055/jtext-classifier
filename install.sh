#!/bin/bash
R_DIR=`dirname $0`
HOMEDIR=$(cd $R_DIR; pwd)
mkdir -p $HOMEDIR/data
mkdir -p $HOMEDIR/tmp/data

echo "== Making LibLinear."
cd $HOMEDIR/liblinear-1.94
make
echo ""

echo "== Compiling Okura Morpheme Analyzer."
cd $HOMEDIR
sh $HOMEDIR/okura-compile.sh
