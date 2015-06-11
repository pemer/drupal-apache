FROM centos:centos6
MAINTAINER Patrick Emer <pemer@afdata.de>
EXPOSE 8080:80
WORKDIR /var/www/html
# VOLUME $(pwd)/files:/var/www/html/sites/default/files 
# VOLUME $(pwd)/tmp:/tmp  
ENV drupal_version 7.37
ADD epel-release-6-8.noarch.rpm /root/epel-release-6-8.noarch.rpm

# install our environment
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

# CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
# /usr/sbin/httpd -D FOREGROUND
