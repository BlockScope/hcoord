#!/bin/sh

#set +v

stack install build-hcoord --stack-yaml=stack-build.yaml
build-hcoord $@
