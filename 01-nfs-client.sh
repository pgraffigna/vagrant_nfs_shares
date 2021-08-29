#!/bin/bash
# nfs-client config

#Colores
greenColor="\e[0;32m\033[1m"
redColor="\e[0;31m\033[1m"
yellowColor="\e[0;33m\033[1m"
blueColor="\e[0;34m\033[1m"
endColor="\033[0m\e[0m"

echo -e "${yellowColor}Actualizando e instalando los paquetes necesarios ${endColor}"
sudo apt-get update && sudo apt-get install -y nfs-common -qq

echo -e "${yellowColor}Creando directorio y montando la compartida ${endColor}"
sudo mkdir /mnt/nfs
echo '192.168.60.3:/ /mnt/nfs nfs4 intr 0 0' | sudo tee -a /etc/fstab
sudo mount -a

echo -e "${yellowColor}Desactivando el servicio rpcbind ${endColor}"
sudo systemctl disable --now rpcbind.service rpcbind.socket

echo -e "${yellowColor}Chequeando el contenido de la compartida"
ls -l /mnt/nfs

echo -e "${greenColor}Todos los procesos terminaron correctamente!!!"
