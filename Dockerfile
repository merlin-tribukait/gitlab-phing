FROM alpine:edge

RUN apk update
RUN apk upgrade
RUN apk add openssh zip unzip git curl zlib
ENV OC_VERSION=7.08
ENV LD_LIBRARY_PATH /usr/local/lib:/usr/lib:/lib

RUN apk --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community  add \
        bash \
        ca-certificates \
        git \
        openssh \
        curl \
        unzip \
        php7 \
        php7-xml \
        php7-gd \
        php7-opcache \
        php7-zip \
        php7-xmlreader \
        php7-zlib \
        php7-opcache \
        php7-mcrypt \
        php7-openssl \
        php7-curl \
        php7-json \
        php7-dom \
        php7-xmlwriter \
        php7-tokenizer \
        php7-ctype \
        php7-simplexml \
        php7-phar \
        php7-mbstring \
        php7-xsl \
        php7-curl 

RUN echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
	&& apk add --update --no-cache --virtual=build-dependencies \ 
		automake \
		autoconf \	
		gcc \
		g++ \
		gettext \
		git \
		linux-headers \
		libtool \
		libxml2-dev \
		make \
		openssl-dev \
		pkgconfig \
		wget \
		vpnc \
	
	&& git clone https://github.com/dlenski/openconnect.git \
	&& cd openconnect \
	&& git checkout 4ed81ced12581b51616adb085c71586e5fb5e66b \
	&& ./autogen.sh \
	&& ./configure --with-vpnc-script=/etc/vpnc/vpnc-script --without-openssl-version-check \
	&& make install \
	&& apk del --purge build-dependencies \
	&& rm -rf /tmp/*
RUN apk add --no-cache \
		openssl \
		libxml2 \
		vpnc

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('SHA384', 'composer-setup.php') === '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/bin/composer
RUN chmod +x /usr/bin/composer
RUN composer global require hirak/prestissimo
RUN composer global require phing/phing pear/versioncontrol_git:"dev-master"
RUN mkdir /root/.ssh 
COPY .gitconfig /root/.gitconfig
COPY config /root/.ssh 
ENV PATH="/root/.composer/vendor/bin:${PATH}"
COPY runner.sh /runner.sh
COPY vpn.sh /vpn.sh
CMD ["/vpn.sh"]
CMD ["/runner.sh"]
