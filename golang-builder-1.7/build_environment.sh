#!/bin/bash

tagName=$1

# Grab the source code
go get -d github.com/$REPONAME/...

# Grab Go package name
pkgName=github.com/$REPONAME

if [ -z "$pkgName" ];
then
  echo "Error: Must add package name as env var"
  exit 992
fi

# Grab just first path listed in GOPATH
goPath="${GOPATH%%:*}"

# Construct Go package path
pkgPath="$goPath/src/$pkgName"

if [ -e "$pkgPath/vendor" ];
then
    # Enable vendor experiment
    export GO15VENDOREXPERIMENT=1
elif [ -e "$pkgPath/Godeps/_workspace" ];
then
  # Add local godeps dir to GOPATH
  GOPATH=$pkgPath/Godeps/_workspace:$GOPATH
fi
