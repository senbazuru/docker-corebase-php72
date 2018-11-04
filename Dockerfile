FROM centos:7
MAINTAINER senbazuru

RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 && \
    rpm --import https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7 && \
    rpm --import http://rpms.remirepo.net/RPM-GPG-KEY-remi

RUN yum update -y  && \
    yum groupinstall -y "Development Tools"

RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
    http://rpms.famillecollet.com/enterprise/remi-release-7.rpm

RUN yum install -y --enablerepo=remi,remi-php72 \
    php \
    php-opcache \
    php-mbstring \
    php-pdo \
    php-pecl-memcache \
    php-pecl-memcached \
    php-pecl-redis \
    php-pecl-imagick \
    php-mcrypt \
    php-xml \
    php-gd \
    php-devel \
    php-gd \
    php-pgsql \
    php-pecl-ssh2 \
    php-process \
    php-intl \
    php-pear \
    php-pecl-zip \
    php-pecl-apcu \
    postgresql 

RUN rm -rf /var/cache/yum/* \
    && yum clean all

# composer
RUN curl https://getcomposer.org/installer -o /tmp/installer
RUN cat /tmp/installer | php -- --install-dir=/usr/local/bin
RUN mv /usr/local/bin/composer.phar /usr/local/bin/composer
RUN chmod 755 /usr/local/bin/composer
RUN rm -rf /tmp/installer
