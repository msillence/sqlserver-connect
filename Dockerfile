FROM debezium/connect:2.0.0.Final

USER root

RUN /usr/bin/microdnf -y update
RUN /usr/bin/microdnf install -y telnet iputils bind-utils less jq unzip

#RUN rm /kafka/libs/reload4j-*.jar /kafka/libs/slf4j-reload4j-*.jar

# reconfigure logging
# RUN sed -i 's/export KAFKA_LOG4J_OPTS.*/export KAFKA_LOG4J_OPTS="-Dlog4j2.configurationFile=\/kafka\/libs\/log4j2.xml"/' /docker-entrypoint.sh

USER kafka
WORKDIR /kafka

# include avro, jmx-promethus
COPY target/deps/* /kafka/libs/

# copy logging config
# COPY log4j2.xml /kafka/libs/

COPY kafka-connect.yml /kafka/kafka-connect.yml

# there aren't many options for additional JVM options exposed by the entrypoint script this is abusing the HEAP option
ENV HEAP_OPTS="-javaagent:/kafka/libs/jmx_prometheus_javaagent-0.16.1.jar=7072:/kafka/kafka-connect.yml"