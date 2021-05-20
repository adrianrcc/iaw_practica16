# IMAGEN BASE
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

# INSTALACIÓN DE GIT, DESCARGA APLICACIÓN WEB, MODIFICAMOS CONFIG.PHP Y BORRAMOS INDEX.HTML
RUN apt install git -y \
    && git clone https://github.com/josejuansanchez/iaw-practica-lamp \
    && mv /iaw-practica-lamp/src/* /var/www/html/ \
    && sed -i 's/localhost/mysql/' /var/www/html/config.php \
    && rm /var/www/html/index.html

# EXPONEMOS EL PUERTO 80
EXPOSE 80

# INDICAMOS EL COMANDO QUE SE EJECUTA PARA CREAR EL CONTENEDOR Y NO PERMITIMOS EJECUTAR NINGÚN OTRO COMANDO DURANTE LA CREACIÓN
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
