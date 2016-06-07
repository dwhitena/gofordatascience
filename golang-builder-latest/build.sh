#!/bin/bash -e

source /build_environment.sh

echo "here 6"

# time the compile of the statically linked version of package
echo "Building $pkgName"
time go install -v $pkgName/...
