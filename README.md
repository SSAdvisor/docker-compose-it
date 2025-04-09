# DOCKER-COMPOSE-IT

This repository aims to create a common place for docker compose files that create a singular docker container for each service. This includes installing services that may be missing from the docker image being installed but needed by the container to execute commands to communicate with other docker container networks. For example I install an individual docker container for mysql with a named network of mysql_network and then I install an individual wordpress docker container that uses the mysql_network to connect to the other container but to do this I need to install the mysql client in the wordpress container.

## Requirements
- Docker version >= 28.0.4
- Docker compose version >= 2.34.0

## Directory Structure

### mysql
```
|_> mysql/
|____> docker-compose.yml
```

### wordpress
```
|_> wordpress/
|____> docker_compose.yml
|____> init-script.sh
|____> init-scripts/
|______> 01-create-database.sql
```

## Prepare for Execution
Modify the docker-compose-it/secrets/mysql_root_password.txt and docker-compose-it/secrets/wordpress_db_password.txt files with a secure password.

## Execution
```
cd docker-compose-it/mysql
docker compose up -d
cd docker-compose-it/wordpress
docker compose up -d
```

## Review the logs
```
cd docker-compose-it/wordpress
docker compose logs
```

## Stop the system
```
cd docker-compose-it/wordpress
docker compose stop
cd docker-compose-it/mysql
docker compose mysql
```

## Cautions
Do not stop the mysql container if you have other containers using the mysql_network. If you do you could cause irreparable damage to dependent systems.