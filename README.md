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



