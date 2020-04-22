#!/bin/sh

#set +v

stack install build-hcoord
build-hcoord $@
