#!/bin/sh

echo "this can take some time. get some tea."
/shared/wait-for-it.sh cassandra:9042 -t 300 -- cqlsh --cqlversion=3.4.4 cassandra < /bg_init/schema.cql
PYTHONPATH=/opt/graphite/lib/ bgutil --cassandra_contact_points=cassandra syncdb --storage-schemas /biggraphite/storage-schemas.conf