#!/bin/bash

JBOSS_CLI=$JBOSS_HOME/bin/jboss-cli.sh
POSTGRES_DRIVER_JAR=postgresql-$POSTGRES_DRIVER_VERSION.jar

function wait_for_server() {
  until `$JBOSS_CLI -c "ls /deployment" &> /dev/null`; do
    sleep 1
  done
}

function setup_driver() {
  $JBOSS_CLI -c << EOF
batch
module add --name=org.postgres --resources=/tmp/$POSTGRES_DRIVER_JAR --dependencies=javax.api,javax.transaction.api
/subsystem=datasources/jdbc-driver=postgres:add(driver-name="postgres",driver-module-name="org.postgres",driver-class-name=org.postgresql.Driver)
run-batch
EOF
}

curl -o /tmp/$POSTGRES_DRIVER_JAR https://jdbc.postgresql.org/download/$POSTGRES_DRIVER_JAR

$JBOSS_HOME/bin/standalone.sh > /dev/null &
wait_for_server
setup_driver
$JBOSS_CLI -c :shutdown

# Fix for WFLYCTL0056: Could not rename /opt/jboss/wildfly/standalone/configuration/standalone_xml_history/current to ...
rm -rf /opt/jboss/wildfly/standalone/configuration/standalone_xml_history/current

rm /tmp/$POSTGRES_DRIVER_JAR
