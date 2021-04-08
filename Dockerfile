# we will inherit from  the Debian image on DockerHub
FROM debian

# set timezone so files' timestamps are correct
ENV TZ=Europe/Madrid

# install apache and php 7.3 and modsecurity
# we include procps and telnet so you can use these with shell.sh prompt
RUN apt-get update -qq >/dev/null && apt-get install -y -qq procps telnet apache2 php7.3 -qq >/dev/null && apt-get install modsecurity-crs


# HTML server directory
WORKDIR /var/www/html
COPY . /var/www/html/


# The PHP app is going to save its state in /data so we make a /data inside the container
RUN mkdir /data && chown -R www-data /data && chmod 755 /data & chmod 777 -R /var/www/html/

# we need custom php configuration file to enable userdirs
COPY php.conf /etc/apache2/mods-available/php7.3.conf

# enable userdir and php
RUN a2enmod php7.3 && a2enmod headers && a2enmod ssl

# Copy config. apache2 
COPY apache2.conf /etc/apache2
COPY 000-default.conf /etc/apache2/sites-available
COPY modsecurity.conf-recommended /etc/modsecurity/modsecurity.conf

#activate pag def
RUN a2ensite 000-default.conf && a2ensite default-ssl.conf

# Remove module mod_autindex
RUN a2dismod -f autoindex.load && service apache2 restart

# we run a script to stat the server; the array syntax makes it so ^C will work as we want
CMD  ["./entrypoint.sh"]
