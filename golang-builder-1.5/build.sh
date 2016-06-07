#!/bin/bash -e

source /build_environment.sh

# time the compile of the statically linked version of package
START_TIME=$(date +%s%N)
go install $pkgName/...
ELAPSED_TIME=$(($(date +%s%N) - $START_TIME))

echo $ELAPSED_TIME
#time go install -v $pkgName/...
