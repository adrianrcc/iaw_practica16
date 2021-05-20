# Implantación de Aplicaciones Web - Práctica 16

Adrián Ramírez-Cruzado Carmona

2º CFGS Admón. de Sistemas Informáticos en Red

IES Celia Viñas (Almería) - 2020/2021

# Repositorio del proyecto

- [https://github.com/adrianrcc/iaw_practica16](https://github.com/adrianrcc/iaw_practica16)

# Práctica 16: «Dockerizar» una aplicación LAMP

## Descripción del proceso:

En esta práctica tendremos que crear un archivo Dockerfile para crear una imagen Docker que contenga una aplicación web LAMP. Posteriormente realizaremos la implantación del sitio web en Amazon Web Services (AWS) haciendo uso de contenedores Docker y de la herramienta Docker Compose.

### 1. Tareas a realizar

A continuación se describen muy brevemente algunas de las tareas que realizaremos:

- Crear una máquina virtual Amazon EC2.

- Instalar y configurar Docker y Docker compose en la máquina virtual.

- Crear un archivo Dockerfile para crear una imagen que contenga el servicio de Apache con la siguiente aplicación web: https://github.com/josejuansanchez/iaw-practica-lamp

- Crear un archivo docker-compose.yml para poder desplegar los servicios de Apache, MySQL y phpMyAdmin. Utilizaremos las imágenes oficiales de Docker Hub.

- Comprobar que podemos acceder a los servicios de Apache y phpMyAdmin desde un navegador web.

### 2. Requisitos del archivo Dockerfile

Tendremos que crear un archivo Dockerfile con los siguientes requisitos:

- Como imagen base utilizaremos la versión de ubuntu que está etiquetada como focal:

    ~~~
    FROM ubuntu:focal
    ~~~

- Instalaremos el software necesario para poder ejecutar el servicio de Apache y servir una aplicación web escrita en PHP que hace uso de una base de datos MySQL:

    ~~~
    RUN apt-get update \ 
        && apt-get install -y apache2 \
        && apt-get install -y php \
        && apt-get install -y libapache2-mod-php \
        && apt-get install -y php-mysql
    ~~~

- **Importante:** Para realizar la instalación de los paquetes será necesario configurar la variable de entorno "DEBIAN_FRONTEND" con el valor "noninteractive":

    ~~~
    ENV DEBIAN_FRONTEND=noninteractive 
    ~~~

- Deberemos copiar el código de la aplicación web en el directorio **/var/www/html**, que es el directorio que utiliza Apache para servir el contenido. La aplicación web está en el siguiente repositorio de GitHub: **https://github.com/josejuansanchez/iaw-practica-lamp**

    ~~~
    RUN apt install git -y \
        && git clone https://github.com/josejuansanchez/iaw-practica-lamp \
        && mv /iaw-practica-lamp/src/* /var/www/html/ \
    ...
    ~~~

- **Importante:** Tendremos que modificar el archivo de configuración "config.php" y sustituir el nombre de localhost por el nombre del servicio donde se estará ejecutando el servicio de MySQL:

    ~~~
    ... 
    && sed -i 's/localhost/mysql/' /var/www/html/config.php \
    ...
    ~~~
- **Importante:** Apache está configurado por defecto para darle prioridad al archivo "index.html", sin embargo, el archivo principal de la web se llama "index.php":

    ~~~
    ...
    && rm /var/www/html/index.html
    ...
    ~~~

- El puerto que usará la imagen para ejecutar el servicio de Apache será el puerto 80:

    ~~~
    EXPOSE 80
    ~~~

### 3 Requisitos del archivo docker-compose.yml

#### 3.1 Servicio de MySQL

- Utilizaremos la última versión de la imagen de MySQL disponible en Docker Hub.

- **Importante:** Para poder configurar la contraseña del usuario root mediante variables de entorno con la última versión de MySQL, debemos iniciar el servicio con el siguiente modificador: **--default-authentication-plugin=mysql_native_password**

    ~~~
    services:
      mysql:
        image: mysql
        command: --default-authentication-plugin=mysql_native_password
    ~~~

- **Importante:** La imagen oficial de MySQL está preparada para permitirnos importar un script SQL con la base de datos inicial de nuestra aplicación: 

    ~~~
    DROP DATABASE IF EXISTS lamp_db;
    CREATE DATABASE lamp_db CHARSET utf8mb4;
    USE lamp_db;

    CREATE TABLE users (
        id int(11) NOT NULL auto_increment,
        name varchar(100) NOT NULL,
        age int(3) NOT NULL,
        email varchar(100) NOT NULL,
        PRIMARY KEY (id)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8;

    CREATE USER IF NOT EXISTS 'lamp_user'@'%';
    SET PASSWORD FOR 'lamp_user'@'%' = 'lamp_password';
    GRANT ALL PRIVILEGES ON lamp_db.* TO 'lamp_user'@'%';
    ~~~

- Para importar la base de datos de la aplicación web crearemos un volumen de tipo bind mount entre el directorio de su máquina local donde está el script SQL y el directorio **"/docker-entrypoint-initdb.d"** de la imagen oficial de MySQL. 

    Esto hará que la primera vez que se instancie la base de datos leerá todos los archivos con extensión .sql que estén en este directorio y se ejecutarán.

    A continuación se muestra un ejemplo de cómo tendría que hacerlo en el archivo docker-compose.yml:

    ~~~
        volumes:
          - mysql_data:/var/lib/mysql
          - ./sql:/docker-entrypoint-initdb.d 
    ~~~

### 4 Networks

Los servicios definidos en el archivo docker-compose.yml usan dos redes:

~~~     
networks: 
  frontend-network:
  backend-network:
~~~   

Los servicios Apache y phpMyAdmin se conectan con el servicio MySQL a través de la red backend-network. Nosotros nos conectamos a los servicios Apache y phpMyAdmin a través de la red frontend-network a través de los puertos 80 y 8080 respectivamente. Sólo los servicios que están en la red frontend-network expondrán sus puertos en el host. Por lo tanto, el servicio de MySQL no deberá estar accesible desde el host.

### 5 Docker restart policies

Usamos una política de reinicio para que los contenedores se reinicien cada vez que se detengan de forma inesperada.

~~~
restart: always
~~~

### 6 Orden en el que se inician los servicios

"depends_on" expresa la dependencia entre los servicios, es decir, "docker-compose up" iniciará los servicios en orden de dependencia. 

~~~
depends_on: 
      - mysql
~~~

**Nota**: depends_on no esperará a que mysql esté "listo" antes de iniciar phpMyAdmin y Apache, sólo hasta que se hayan iniciado. 
