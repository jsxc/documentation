#!/bin/sh

PHINXBUILD=sphinx-build
SOURCEDIR=.
BUILDDIR=_build
LOGFILE=sphinx-errors.log
ERROR=0

echo "Testing commit..."

$PHINXBUILD -q -E -w $LOGFILE -b html "$SOURCEDIR" "$BUILDDIR"
if test -s $LOGFILE; then
    echo "\n[ERROR] Your commit was NOT processed due to the above build errors! Add \"-n\" to ignore this error and commit anyway."
    ERROR=1
fi

rm -f $LOGFILE
exit $ERROR
