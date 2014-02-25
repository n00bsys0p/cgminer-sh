#!/bin/bash

DIR=$(dirname $(readlink -f $0))

function call()
{
	echo -ne $($DIR/lib/api.py $1) | python -mjson.tool
}
