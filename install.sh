#!/bin/bash
HOMEDIR=`dirname $0`
mkdir -p $HOMEDIR/data
mkdir -p $HOMEDIR/tmp/data

cd $HOMEDIR/liblinear-1.94
make
cd $HOMEDIR
