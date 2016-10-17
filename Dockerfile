FROM gocd-agent:16.9.0
LABEL name="GoCD Agent 16.9.0 + Ansible 2.3.0 (14.04.5 LTS, Trusty Tahr)"

USER root

ENV DEBIAN_FRONTEND noninteractive

# Ansible 2.3.0
# @desc Build the latest ansible from source >= 2.3.0
RUN \
    apt-get update -y; \
    apt-get install -y \
        # utils
        curl \
        wget \
        git \
        nano \
        # ansible deps
        make \
        rpm \
        python-setuptools \
        python2.7-dev \
        asciidoc \
        sshpass \
        alien; \
    # clone ansible
    cd /opt; \
    git clone git://github.com/ansible/ansible.git --recursive; \
    # make ansible
    cd ./ansible; \
    make rpm; \
    # install ansible
    alien -i ./rpm-build/ansible-*.noarch.rpm; \
    # install pip
    wget https://bootstrap.pypa.io/get-pip.py; \
    python get-pip.py; \
    # install yaml + Jinja2
    pip install pyyaml Jinja2

# PHP 7
# @desc Build (Composer) only; Run tests in Docker containers as best practice.
RUN apt-get install -y language-pack-en-base; \
    LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php; \
    apt-get update -y; \
    apt-get install -y --force-yes \
    # xml
    libxml2-dev \
    # sqlite
    sqlite3 \
    libsqlite3-dev \
    # zlib
    zlib1g-dev \
    # libmcrypt
    libmcrypt-dev \
    # libicu
    libicu-dev \
    # libpng
    libpng-dev \
    # gd libs
    libjpeg-dev \
    libfreetype6-dev \
    libpng12-dev \
    # php
    php7.0 \
    php7.0-common \
    php7.0-opcache \
    php7.0-json \
    php7.0-curl \
    php7.0-mysql \
    php7.0-sqlite3 \
    php7.0-phpdbg \
    php7.0-mbstring \
    php7.0-gd \
    php7.0-soap \
    php7.0-imap \
    php7.0-ldap \
    php7.0-pgsql \
    php7.0-pspell \
    php7.0-recode \
    php7.0-tidy \
    php7.0-dev \
    php7.0-intl \
    php7.0-curl \
    php7.0-zip \
    php7.0-xml \
    php7.0-ssh2 \
    ; \
    # install composer
    curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

ENV DEBIAN_FRONTEND teletype
