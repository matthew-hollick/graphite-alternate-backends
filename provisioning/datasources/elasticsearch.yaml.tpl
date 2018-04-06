apiVersion: 1

deleteDatasources:
  - name: Elasticsearch-Production
    orgId: 1
  - name: Elasticsearch-Staging
    orgId: 1
  - name: Elasticsearch-QA
    orgId: 1
  - name: Elasticsearch-Development
    orgId: 1
  - name: Elasticsearch-ExternalTest
    orgId: 1
  - name: Elasticsearch-Integration
    orgId: 1

datasources:
- name: Elasticsearch-Production
  type: elasticsearch
  access: proxy
  orgId: 1
  url: https://kibana.tools.production.tax.service.gov.uk/elasticsearch
  password:
  user:
  database:
  basicAuth: true
  basicAuthUser: {{ MDTP_USERNAME }}
  basicAuthPassword: {{ MDTP_PASSWORD }}
  withCredentials:
  isDefault: false
  jsonData:
     esVersion: 56
     indexName: "[logstash-]YYYY.MM.DD"
  version: 1
  editable: true
- name: Elasticsearch-Staging
  type: elasticsearch
  access: proxy
  orgId: 1
  url: https://kibana.tools.staging.tax.service.gov.uk/elasticsearch
  password:
  user:
  database:
  basicAuth: true
  basicAuthUser: {{ MDTP_USERNAME }}
  basicAuthPassword: {{ MDTP_PASSWORD }}
  withCredentials:
  isDefault: false
  jsonData:
     esVersion: 56
     indexName: "[logstash-]YYYY.MM.DD"
  version: 1
  editable: true
- name: Elasticsearch-QA
  type: elasticsearch
  access: proxy
  orgId: 1
  url: https://kibana.tools.qa.tax.service.gov.uk/elasticsearch
  password:
  user:
  database:
  basicAuth: true
  basicAuthUser: {{ MDTP_USERNAME }}
  basicAuthPassword: {{ MDTP_PASSWORD }}
  withCredentials:
  isDefault: false
  jsonData:
     esVersion: 56
     indexName: "[logstash-]YYYY.MM.DD"
  version: 1
  editable: true
- name: Elasticsearch-ExternalTest
  type: elasticsearch
  access: proxy
  orgId: 1
  url: https://kibana.tools.externaltest.tax.service.gov.uk/elasticsearch
  password:
  user:
  database:
  basicAuth: true
  basicAuthUser: {{ MDTP_USERNAME }}
  basicAuthPassword: {{ MDTP_PASSWORD }}
  withCredentials:
  isDefault: false
  jsonData:
     esVersion: 56
     indexName: "[logstash-]YYYY.MM.DD"
  version: 1
  editable: true
- name: Elasticsearch-Development
  type: elasticsearch
  access: proxy
  orgId: 1
  url: https://kibana.tools.development.tax.service.gov.uk/elasticsearch
  password:
  user:
  database:
  basicAuth: true
  basicAuthUser: {{ MDTP_USERNAME }}
  basicAuthPassword: {{ MDTP_PASSWORD }}
  withCredentials:
  isDefault: false
  jsonData:
     esVersion: 56
     indexName: "[logstash-]YYYY.MM.DD"
  version: 1
  editable: true
- name: Elasticsearch-Integration
  type: elasticsearch
  access: proxy
  orgId: 1
  url: https://kibana.tools.integration.tax.service.gov.uk/elasticsearch
  password:
  user:
  database:
  basicAuth: true
  basicAuthUser: {{ MDTP_USERNAME }}
  basicAuthPassword: {{ MDTP_PASSWORD }}
  withCredentials:
  isDefault: false
  jsonData:
     esVersion: 56
     indexName: "[logstash-]YYYY.MM.DD"
  version: 1
  editable: true
