FROM centos:centos6
MAINTAINER Patrick Emer <pemer@afdata.de>
WORKDIR /var/www/html
ENV drupal_version 7.37
ENV DB_DATABASE drupal
ADD epel-release-6-8.noarch.rpm /root/epel-release-6-8.noarch.rpm

# install the environment
RUN \
    rpm -Uvh /root/epel-release-6-8.noarch.rpm && \
    yum -y update && \
    yum install -y tar wget && \ 
    yum install httpd php php-xmlrpc php-xml php-pecl-apc php-mysql php-mcrypt php-pecl-redis php-mbstring php-dba php-pear php-bcmath php-common php-gd php-pdo -y && \
    rm -f /root/epel-release-6-8.noarch.rpm

# make base drupal extraction
RUN \
    wget http://ftp.drupal.org/files/projects/drupal-$drupal_version.tar.gz -O ../drupal.tar.gz && \
    tar -xf ../drupal.tar.gz --strip=1

ADD settings.php /var/www/html/sites/default/settings.php 
