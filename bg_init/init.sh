#!/bin/sh

echo "this can take some time. get some tea."
/shared/wait-for-it.sh cassandra:9042 -t 300 -- cqlsh cassandra /bg_init/schema.cql
bgutil --cassandra_contact_points cassandra syncdb --storage-schemas /biggraphite/storage-schemas.conf