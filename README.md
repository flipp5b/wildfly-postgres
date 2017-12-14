# wildfly-postgres

## Build instructions

To build local image, use
```
docker build -t wildfly-postgres \
    --build-arg WILDFLY_VERSION=<WildFly Version> \
    --build-arg POSTGRES_DRIVER_VERSION=<PostrgeSQL JDBC Driver Version> \
    .
```
E.g.
```
docker build -t wildfly-postgres \
    --build-arg WILDFLY_VERSION=11.0.0.Final \
    --build-arg POSTGRES_DRIVER_VERSION=42.1.4 \
    .
```

To publish the image, use
```
docker tag wildfly-postgres flipp5b/wildfly-postgres:<tag>
docker push flipp5b/wildfly-postgres:<tag>
```
E.g.
```
docker tag wildfly-postgres flipp5b/wildfly-postgres:11.0.0.Final-42.1.4
docker push flipp5b/wildfly-postgres:11.0.0.Final-42.1.4
```