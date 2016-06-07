#!/bin/bash

tagName=$1

# Grab the source code
go get -d github.com/hashicorp/consul/...

echo "here 1"

# Grab Go package name
pkgName=github.com/hashicorp/consul

echo "here 2"

if [ -z "$pkgName" ];
then
  echo "Error: Must add package name as env var"
  exit 992
fi

echo "here 3"

# Grab just first path listed in GOPATH
goPath="${GOPATH%%:*}"

echo "here 4"

# Construct Go package path
pkgPath="$goPath/src/$pkgName"

echo "here 5"

if [ -e "$pkgPath/vendor" ];
then
    # Enable vendor experiment
    export GO15VENDOREXPERIMENT=1
elif [ -e "$pkgPath/Godeps/_workspace" ];
then
  # Add local godeps dir to GOPATH
  GOPATH=$pkgPath/Godeps/_workspace:$GOPATH
else
  # Get all package dependencies
  go get -d -v $pkgName/...
fi
