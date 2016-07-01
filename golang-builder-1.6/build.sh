#!/bin/bash -e

source /build_environment.sh

# get the number of dependencies in the repo
go list $pkgName/... > dep.log || true
deps=`wc -l dep.log | cut -d' ' -f1`;

# get number of lines of go code
golines=`( find $pkgPath -name '*.go' -print0 | xargs -0 cat ) | wc -l`

# time the compile of the statically linked version of package
START_TIME=$(date +%s%N)
go build $pkgName/... >>compile.log 2>&1 || true
ELAPSED_TIME=$(($(date +%s%N) - $START_TIME))

lines=`wc -l compile.log | awk '{print $1}'`;
if [ $lines -gt 0 ];
then
   echo $REPONAME, "error", $deps, $golines
else
   echo $REPONAME, $ELAPSED_TIME, $deps, $golines
fi

# clean up
rm compile.log
rm dep.log
rm -r $GOPATH/src/*
rm -r $GOPATH/bin/*
rm -r /src/*
