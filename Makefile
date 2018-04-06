include envfile
export $(shell sed 's/=.*//' envfile)

.PHONY: templates run

all: templates run

templates:
	@echo "running templates"
	@echo "MDTP_USERNAME is \"$(MDTP_USERNAME)\""
	envtpl --keep-template -o \
		provisioning/datasources/elasticsearch.yaml \
		provisioning/datasources/elasticsearch.yaml.tpl

run:
	docker-compose up
