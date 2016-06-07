#!/bin/bash -e

source /build_environment.sh

# time the compile of the statically linked version of package
echo "Building $pkgName"
START_TIME=$(date +%s%N)
go install -v $pkgName/...
ELAPSED_TIME=$(($(date +%s%N) - $START_TIME))

echo $ELAPSED_TIME
#time go install -v $pkgName/...
