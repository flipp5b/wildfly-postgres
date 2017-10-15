#!/bin/bash

JBOSS_CLI=$JBOSS_HOME/bin/jboss-cli.sh

function wait_for_server() {
  until `$JBOSS_CLI -c "ls /deployment" &> /dev/null`; do
    sleep 1
  done
}

$JBOSS_HOME/bin/standalone.sh > /dev/null &

wait_for_server

printenv > env.properties
$JBOSS_CLI -c --file=$1 --properties=env.properties
$JBOSS_CLI -c :shutdown
rm env.properties

# Fix for WFLYCTL0056: Could not rename /opt/jboss/wildfly/standalone/configuration/standalone_xml_history/current to ...
rm -rf $JBOSS_HOME/standalone/configuration/standalone_xml_history/current
