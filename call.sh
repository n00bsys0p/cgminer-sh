#!/bin/bash

# cgminer shell API

# Written by n00bsys0p

# Init
DIR=$(dirname $(readlink -f $0))
. $DIR/lib/functions.sh

# Functions
function usage()
{
	echo "Usage: $0 {apirequestname}" >&2
}

# Sanity check
if [ $# -lt 1 ]; then
	usage
	exit 1
fi

call $1
