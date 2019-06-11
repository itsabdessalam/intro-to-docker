# Commandes docker tp

<h3>Step 1</h3>

```bash
docker container run --name nginx -d -v $(pwd)/using-docker-commands/tp/step1/:/usr/share/nginx/html -p 8080:80 nginx
```

<p>Pour permettre la communication entre les containers on crée deux réseaux afin de linker les containers par la suite</p>

```bash
docker network create my-custom-network-1
docker network create my-custom-network-2
```

<h3>Step 2</h3>

```bash
docker container run --name php -d -v $(pwd)/using-docker-commands/tp/step2/code:/code --network=custom-network-1 php:fpm

docker container run --name nginx -d -v $(pwd)/using-docker-commands/tp/step2/code:/code -v $(pwd)/using-docker-commands/tp/step2/site.conf:/etc/nginx/conf.d/default.conf --link php:php --network=custom-network-1 -p 8080:80 nginx
```

<h3>Step 3</h3>

```bash

docker network create my-custom-network-1
docker network create my-custom-network-2

rm -rf ~/Desktop/Courses/DevOps/docker/using-docker-commands/tp/step3/mysql/*

docker container run --name mariadb -e MYSQL_DATABASE=mariadocker -e MYSQL_ROOT_PASSWORD=root -e MYSQL_ALLOW_EMPTY_PASSWORD=yes -d -v $(pwd)/using-docker-commands/tp/step3/mysql:/var/lib/mysql -v $(pwd)/using-docker-commands/tp/step3/scripts:/docker-entrypoint-initdb.d --network=custom-network-2 mariadb

docker container run --name php -d -v $(pwd)/using-docker-commands/tp/step3/code:/code --link mariadb:mariadb --network=custom-network-2 php:fpm

docker exec -i php docker-php-ext-install pdo_mysql

docker restart php

docker container run --name nginx -d -v $(pwd)/using-docker-commands/tp/step3/site.conf:/etc/nginx/conf.d/default.conf --link php:php --network=custom-network-2 -p 8080:80 nginx
```
