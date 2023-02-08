#!/bin/sh

WORKDIR='/home/jovyan/work'

[ -f $WORKDIR/Makefile ] || cp /tmp/Makefile $WORKDIR
[ -d $WORKDIR/data/ ] || mkdir $WORKDIR/data/

