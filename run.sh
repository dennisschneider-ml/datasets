#!/bin/sh

echo "Being executed to $WORKDIR ..."
[ -f $WORKDIR/Makefile ] || echo "Makefile being created ..."
[ -f $WORKDIR/Makefile ] || cp ./assets/Makefile $WORKDIR
[ -d $WORKDIR/data/ ] || mkdir $WORKDIR/data/

