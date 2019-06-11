# Containers with docker commands

> The challenge is to create containers and interact with them only with commands.
> You shouldn't use Dockerfile or docker-compose

## Instructions

### Step 1

- Create an nginx web server container with custom html page

### Step 2

- Create an nginx web server container with custom html page
- Create a container for PHP scripts
- Make sure these two containers are communicating. You can add a page containing ```phpinfo();``` to verify.

### Step 3

In addition to step 2 you have to add a container for a database.

- Make sure that the three containers communicate.
- Add custom php page in which you get and update a field in database. Why not a counter ?

<details>
<summary>Solutions</summary>
<h3>Step 1</h3>

```bash
docker container run --name nginx -d -v $(pwd)/using-docker-commands/tp/step1/:/usr/share/nginx/html -p 8080:80 nginx
```

<p>To allow communication between containers we have to create networks</p>

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
rm -rf ~/Desktop/Courses/DevOps/docker/using-docker-commands/tp/step3/mysql/*  

docker container run --name mariadb -e MYSQL_DATABASE=mariadocker -e MYSQL_ROOT_PASSWORD=root -e MYSQL_ALLOW_EMPTY_PASSWORD=yes -d -v $(pwd)/using-docker-commands/tp/step3/mysql:/var/lib/mysql -v $(pwd)/using-docker-commands/tp/step3/scripts:/docker-entrypoint-initdb.d --network=custom-network-2 mariadb

docker container run --name php -d -v $(pwd)/using-docker-commands/tp/step3/code:/code --link mariadb:mariadb --network=custom-network-2 php:7.3-fpm  

docker exec -i php docker-php-ext-install pdo_mysql

docker restart php

docker container run --name nginx -d -v $(pwd)/using-docker-commands/tp/step3/site.conf:/etc/nginx/conf.d/default.conf --link php:php --network=custom-network-2 -p 8080:80 nginx
```

</details>
