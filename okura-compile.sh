#!/bin/bash
HOMEDIR=`dirname $0`
mkdir -p $HOMEDIR/dict
okura compile $1 $HOMEDIR/dict/okura-dict
