#!/bin/bash
# nfs-server config

#Colores
greenColor="\e[0;32m\033[1m"
yellowColor="\e[0;33m\033[1m"
endColor="\033[0m\e[0m"

echo -e "${yellowColor}Actualizando e instalando los paquetes necesarios ${endColor}"
sudo apt-get update && sudo apt-get install -y nfs-kernel-server -qq

echo -e "${yellowColor}Creando directorio y archivo de prueba y reiniciando el servicio ${endColor}"
sudo mkdir /var/nfs && sudo touch /var/nfs/test.txt
echo '/var/nfs *(rw,sync,fsid=0,no_root_squash,no_subtree_check)' | sudo tee -a /etc/exports
sudo systemctl restart nfs-server

echo -e "${yellowColor}Desactivando nfs-version 2 y nfs-version 3 ${endColor}"
sudo echo RPCMOUNTDOPTS="--no-nfs-version 2 --no-nfs-version 3 --nfs-version 4 --no-udp" >> /etc/default/nfs-kernel-server 
sudo echo RPCNFSDOPTS="--no-nfs-version 2 --no-nfs-version 3 --nfs-version 4 --no-udp" >> /etc/default/nfs-kernel-server

echo -e "{yellowColor}Reiniciando y desactivando servicios ${endColor}"
sudo systemctl restart nfs-server
sudo systemctl disable --now rpcbind.service rpcbind.socket
sudo systemctl mask rpcbind.service rpcbind.socket

echo -e "${greenColor}Todos los procesos terminaron correctamente!!!"

