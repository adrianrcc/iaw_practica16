FROM ubuntu:focal

LABEL title="apache&php"

# VARIABLES DE ENTORNO
ENV DEBIAN_FRONTEND=noninteractive 

# ACTUALIZACIÓN REPOSITORIOS
RUN apt-get update
# INSTALACIÓN DE APACHE
RUN apt-get install -y apache2
# INSTALACIÓN DE PHP
RUN apt-get install -y php
# INSTALACIÓN DE LIBRERÍAS NECESARIAS
RUN apt-get install -y libapache2-mod-php
RUN apt-get install -y php-mysql

CMD []
