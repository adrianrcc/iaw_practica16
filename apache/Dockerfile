FROM ubuntu:focal

LABEL title="apache&php"

# VARIABLES DE ENTORNO
ENV DEBIAN_FRONTEND=noninteractive 

# INSTALACIÓN DE APACHE, PHP Y LIBRERÍAS
RUN apt-get update \ 
    && apt-get install -y apache2 \
    && apt-get install -y php \
    && apt-get install -y libapache2-mod-php \
    && apt-get install -y php-mysql

CMD []
