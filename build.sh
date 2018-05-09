#!/bin/sh

#set +v

stack build --copy-bins
__shake-build/build-hcoord $@
