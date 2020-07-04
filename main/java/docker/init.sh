#!/bin/bash
set -e
echo $1
java  $JAVA_OPTS  -jar /$1

exec "$@"