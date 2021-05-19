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

- Como imagen base utilizaremos la versión de ubuntu que está etiquetada como focal.

- Instalaremos el software necesario para poder ejecutar el servicio de Apache y servir una aplicación web escrita en PHP que hace uso de una base de datos MySQL.

- **Importante:** Para realizar la instalación de los paquetes será necesario configurar la variable de entorno "DEBIAN_FRONTEND" con el valor "noninteractive".

    Ejemplo:
    ~~~
    ENV DEBIAN_FRONTEND=noninteractive 
    ~~~

- Deberemos copiar el código de la aplicación web en el directorio **/var/www/html**, que es el directorio que utiliza Apache para servir el contenido. La aplicación web está en el siguiente repositorio de GitHub:
    
    **https://github.com/josejuansanchez/iaw-practica-lamp**

- **Importante:** Tendremos que modificar el archivo de configuración "config.php" y sustituir el nombre de localhost por el nombre del servicio donde se estará ejecutando el servicio de MySQL.

- **Importante:** Apache está configurado por defecto para darle prioridad al archivo "index.html", sin embargo, el archivo principal de la web se llama "index.php".

- El puerto que usará la imagen para ejecutar el servicio de Apache será el puerto 80.


