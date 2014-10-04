#!/bin/bash
HOMEDIR=`dirname $0`
MECAB_NAIST_URL="http://sourceforge.jp/frs/redir.php?m=iij&f=%2Fnaist-jdic%2F53500%2Fmecab-naist-jdic-0.6.3b-20111013.tar.gz"
MECAB_NAIST_FILE="$HOMEDIR/tmp/mecab-naist-jdic-0.6.3b-20111013"
MECAB_NAIST_FILE_GZ="$MECAB_NAIST_FILE.tar.gz"
mkdir -p $HOMEDIR/dict
mkdir -p $HOMEDIR/tmp
curl -L $MECAB_NAIST_URL -o $MECAB_NAIST_FILE_GZ
tar zxvf $MECAB_NAIST_FILE_GZ -C "$HOMEDIR/tmp"
okura compile $MECAB_NAIST_FILE $HOMEDIR/dict/okura-dict
