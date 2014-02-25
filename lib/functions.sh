#!/bin/bash

DIR=$(dirname $(readlink -f $0))
PYTHON=$(which python)

function call()
{
	echo -ne $($PYTHON $DIR/lib/api.py $1) | $PYTHON -mjson.tool
}
