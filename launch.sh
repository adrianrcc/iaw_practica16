#!/bin/bash


# Instalación de docker y docker-compose #

# -------------------------------#
# CONFIGURACIÓN DE LAS VARIABLES #
# -------------------------------#

# Genéricas #
HTTPASSWD_DIR=/home/ubuntu

# ----------------------------#
#         Instalación         #
# ----------------------------#

# Habilitamos el modo de shell para mostrar los comandos que se ejecutan #
set -x

# Actualizamos repositorios #
apt update

# Instalamos docker #
apt install docker -y

# Instalamos docker-compose #
apt install docker-compose -y

# Habilitamos docker y arrancamos servicio #
systemctl enable docker
systemctl start docker

# Lanzamos docker-compose yml en modo detached #
cd $HTTPASSWD_DIR/iaw_practica16
docker-compose up -d
