
# grafana-local

install envtpl `pip install envtpl`
install make

put your credentials into the envfile.
this is not very robust, you may need to manually edit the templated file(s)

```
$ make templates
$ make run
``

point browser at `http://localhost:3000`
username and password are both admin

TODO:
- elasticsearch datasource is broken
# graphite-alternate-backends
