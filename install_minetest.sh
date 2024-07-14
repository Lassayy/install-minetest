#!/bin/bash

# S'assurer que le script est exécuté en tant que superutilisateur
if [ "$(id -u)" -ne 0 ]; then
  echo "Ce script doit être exécuté en tant que root" 1>&2
  exit 1
fi

# Mettre à jour le système
echo "Mise à jour du système..."
apt update && apt upgrade -y

# Installer Minetest Server
echo "Installation de Minetest Server..."
if apt install -y minetest-server; then
  echo "Minetest Server a été installé avec succès."
else
  echo "Échec de l'installation de Minetest Server. Vérifiez que le paquet existe ou que les dépôts sont à jour."
  exit 1
fi

# Configurer le serveur Minetest
echo "Configuration du serveur Minetest..."
cat <<EOL > /etc/minetest/minetest.conf
# Configuration du serveur Minetest
server_name = MonServeurMinetest
server_description = Serveur Minetest pour mes collaborateurs
server_address = 0.0.0.0
server_announce = true
enable_damage = true
creative_mode = false
enable_pvp = true
EOL

# Démarrer et activer le serveur Minetest
echo "Démarrage et activation du serveur Minetest..."
if systemctl start minetest-server && systemctl enable minetest-server; then
  echo "Le serveur Minetest a été démarré et activé avec succès."
else
  echo "Échec lors du démarrage ou de l'activation du serveur Minetest."
  exit 1
fi

# Vérifier le statut du serveur Minetest
echo "Vérification du statut du serveur Minetest..."
systemctl status minetest-server

# Afficher l'adresse IP pour connexion
echo "Pour vous connecter au serveur Minetest, utilisez l'une des adresses IP suivantes :"
hostname -I

echo "Installation et configuration de Minetest Server terminées."

