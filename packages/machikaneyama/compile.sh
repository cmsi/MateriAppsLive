#!/bin/sh

# Compile script for Machikaneyama 2002 written by Synge Todo

BASE=$1
COMPILER=$2

test -z "$BASE" && BASE=cpa2002v009c
test -z "$COMPILER" && COMPILER=gfortran

rm -rf $BASE
tar zxf $BASE.tar.gz
cd $BASE
make fort=$COMPILER
