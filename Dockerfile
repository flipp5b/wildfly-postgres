FROM jboss/wildfly:10.1.0.Final

ARG POSTGRES_DRIVER_VERSION=42.1.4

COPY setup-driver.sh /tmp/
USER root
RUN chown jboss:jboss /tmp/setup-driver.sh
RUN chmod 755 /tmp/setup-driver.sh
USER jboss

RUN /tmp/setup-driver.sh

RUN rm /tmp/setup-driver.sh

RUN $JBOSS_HOME/bin/add-user.sh admin pa55w0rd --silent

EXPOSE 8080 9990

CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
