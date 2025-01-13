# [SymmetricDS](https://symmetricds.org/docs/overview) docker for application replication

## Docker build arguments
- APP_NAME - `engine.name` from *.properties file

## First, install the application to `/opt/symmetric-app`

## Then follow these instructions

### Root server initialization
#### Build:
```
docker build --build-arg APP_NAME=corp-000 --no-cache -t symmetricds .
```
#### Run:
```
docker run -d --restart always -p 31415:31415 --name sym -v /opt/symmetric-app:/opt/symmetric-app symmetricds
```

### Related servers initialization
#### Build:
```
docker build --build-arg APP_NAME=store-001 --no-cache -t symmetricds .
```
#### Run:
```
docker run -d --restart always -p 31415:31415 --name sym -v /opt/symmetric-app:/opt/symmetric-app symmetricds
```
