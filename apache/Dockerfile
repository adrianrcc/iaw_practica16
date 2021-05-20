# IMAGEN BASE
FROM ubuntu:focal

LABEL title="apache&php"

# VARIABLES DE ENTORNO
# "DEBIAN_FRONTEND=noninteractive" nos impide interactuar con el proceso.
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Madrid

# INSTALACIÓN DE APACHE, PHP Y LIBRERÍAS
RUN apt-get update \ 
    && apt-get install -y apache2 \
    && apt-get install -y php \
    && apt-get install -y libapache2-mod-php \
    && apt-get install -y php-mysql

# INSTALACIÓN DE GIT, DESCARGA APLICACIÓN WEB, MODIFICAMOS CONFIG.PHP Y BORRAMOS INDEX.HTML
RUN apt install git -y \
    && git clone https://github.com/josejuansanchez/iaw-practica-lamp \
    && mv /iaw-practica-lamp/src/* /var/www/html/ \
    && sed -i 's/localhost/mysql/' /var/www/html/config.php \
    && rm /var/www/html/index.html

# EXPONEMOS EL PUERTO 80
EXPOSE 80

# Docker ejecutará el comando usando el ENTRYPOINT por defecto, que es /bin/sh -c. Link: https://docs.docker.com/engine/reference/builder/#cmd
# El comando "/usr/sbin/apache2ctl" se usa para controlar la interfaz del servidor HTTP de Apache. Ejemplo: https://hub.docker.com/r/eboraas/apache/dockerfile/
# "-D" para modo detached.
# "FOREGROUND" para que el proceso se lleve a cabo en primer plano.
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
