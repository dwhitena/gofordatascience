#!/bin/bash -e

source /build_environment.sh

# time the compile of the statically linked version of package
START_TIME=$(date +%s%N)
go install $pkgName/... > compile.log
ELAPSED_TIME=$(($(date +%s%N) - $START_TIME))

lines=`wc -l compile.log | awk '{print $1}'`;
if [ $lines -eq 0 ];
then
   echo $REPONAME, $ELAPSED_TIME
else
   echo $REPONAME, "error"
fi
