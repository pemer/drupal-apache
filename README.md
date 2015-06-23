# drupal-apache

### build the container

```
docker build --tag=drupal-apache .
```


### Start the docker with a drupal apache mod_php setup

```
docker run -d -p 8080:80 \
              --name drupal-apache \
              --link mariadb:db \
              -v $(pwd)/files:/var/www/html/sites/default/files \
              -v $(pwd)/tmp:/tmp \
              -e DB_DATABASE=drupal \
              drupal-apache  /usr/sbin/httpd -D FOREGROUND
```

### connect to docker container

```
docker exec -i -t drupal-apache /bin/bash
```

### Howto create a development environment ?

this ist the answear:

```
cd html/
wget http://ftp.drupal.org/files/projects/drupal-7.37.tar.gz -O ../drupal.tar.gz && tar -xf ../drupal.tar.gz --strip=1
cp ../settings.php sites/default/settings.php

docker run -d -p 8088:80 \
              --name drupal-devel \
              --link mariadb:db \
              -v $(pwd)/html:/var/www/html \
              -v $(pwd)/tmp:/tmp \
              -e DB_DATABASE=drupal \
              drupal-apache  /usr/sbin/httpd -D FOREGROUND
```



