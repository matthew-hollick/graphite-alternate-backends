#!/bin/bash

rm -rf /opt/graphite/storage/*.pid
PYTHONPATH=/opt/graphite/lib/
export PYTHONPATH
/shared/wait-for-it.sh cassandra:9042 -t 300 -- echo "."
bg-carbon-cache --nodaemon start