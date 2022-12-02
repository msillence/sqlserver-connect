#!/bin/bash
mvn clean dependency:copy-dependencies -DoutputDirectory=target/deps
docker build -t core-harbor.lighthouse.jhc.uk/platform-of-apps/sqlserver-connect:2.0.0.final-1 .
docker push core-harbor.lighthouse.jhc.uk/platform-of-apps/sqlserver-connect:2.0.0.final-1
