FROM centos:7

RUN yum -y update && \
    yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm && \
    yum clean all

RUN yum install --enablerepo=remi httpd php56 php56-php php56-php-cli php56-php-common php56-php-gd php56-php-mbstring php56-php-mcrypt \
    php56-php-mysqlnd php56-php-pdo php56-php-pear php56-php-pecl-jsonc php56-php-pecl-zip php56-php-process php56-php-xml \
    php56-runtime wget tar -y

RUN wget -q -O bacula-web-latest.tgz https://github.com/bacula-web/bacula-web/releases/download/v8.3.3/bacula-web-8.3.3.tgz && \
    tar -xzf bacula-web-latest.tgz -C /var/www/html/ && \
    mv /var/www/html/bacula-web/* /var/www/html/bacula-web/.htaccess /var/www/html/ && \
    rmdir /var/www/html/bacula-web && \
    chown -R root /var/www/html/ && \
    chmod -R u=rx,g=rx,o=rx /var/www/html/ && \
    chmod -R u=rwx,g=rwx,o=rx /var/www/html/application/views/cache && \
    chmod -R u=rwx,g=rx,o=rx /var/www/html/application/assets/protected && \
    chown -R apache /var/www/html/application/views/cache /var/www/html/application/assets/protected && \
    rm -f bacula-web-latest.tgz

ADD run.sh /run.sh
RUN chmod +x /run.sh
CMD /run.sh
