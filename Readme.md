# debezium config

## configure docker compose

create a .env file with the following configured:
```
BOOTSTRAP_SERVERS=
SCHEMA_REGISTRY=
KAFKA_KEY=
KAFKA_SECRET=
SCHEMA_KEY=
SCHEMA_SECRET=
PROXY_HOST=
PROXY_PORT=
```

start docker

`docker compose up -d`

# configure the server-connect.json and load

Invoke-WebRequest -Uri "http://localhost:8085/connectors" -Method POST -Infile sqlserver-connect.json  -ContentType "application/json"#


# Database config

create schema mstest;

CREATE TABLE mstest.person (id int, name varchar(100), PRIMARY KEY  (id));

insert into mstest.person (id, name) values (8, 'x')

## for cloud

EXEC msdb.dbo.gcloudsql_cdc_enable_db mstest;

## for local

USE MyDB
GO
EXEC sys.sp_cdc_enable_db
GO

# per table

EXEC sys.sp_cdc_enable_table
  @source_schema = N'mstest',
  @source_name = N'person',
  @role_name = N'CDC';

## script
https://www.techbrothersit.com/2013/06/change-data-capture-cdc-sql-server_69.html

see file enable-cdc-en-mass.sql

# debugging

## explore schemas on sqlserver

SELECT * FROM sys.schemas;

## explore exported tables

select name, is_tracked_by_cdc from sys.tables;

# jmx stats config from:

https://raw.githubusercontent.com/prometheus/jmx_exporter/master/example_configs/kafka-connect.yml

# example:

https://github.com/rmoff/debezium-ccloud/blob/master/docker-compose.yml

---
# setup in GCP

CREATE TABLE mstest.person (id int, name varchar(100), PRIMARY KEY  (id));

# https://cloud.google.com/sql/docs/sqlserver/replication/enable-cdc

create schema mstest;

SELECT * FROM sys.schemas;

EXEC msdb.dbo.gcloudsql_cdc_enable_db mstest;

EXEC sys.sp_cdc_enable_table
  @source_schema = N'mstest',
  @source_name = N'person',
  @role_name = N'CDC';


 # check


  SELECT * FROM cdc.mstest_person_CT;

