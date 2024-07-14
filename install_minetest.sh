#!/bin/bash

# Mettre à jour le système
echo "Mise à jour du système..."
apt update && apt upgrade -y

# Installer Minetest Server
echo "Installation de Minetest Server..."
apt install -y minetest-server

# Vérifier si Minetest Server a été installé avec succès
if command -v minetestserver >/dev/null 2>&1; then
    echo "Minetest Server a été installé avec succès."
else
    echo "Échec de l'installation de Minetest Server."
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
systemctl start minetest-server
systemctl enable minetest-server

# Vérifier le statut du serveur Minetest
echo "Vérification du statut du serveur Minetest..."
systemctl status minetest-server

echo "Installation et configuration de Minetest Server terminées."