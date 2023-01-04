#!/bin/bash

# Copie le fichier config du git vers le config de packer
cp config ~/.ssh/config

# Crée un groupe de ressources avec Azure CLI
az group create -n myResourceGroup -l francecentral

# Construit l'image avec Packer
packer build ubuntu.json

# Initialise Terraform
terraform init

# Crée un plan d'exécution avec Terraform
terraform plan -out main.tfplan

# Applique le plan d'exécution avec Terraform
terraform apply main.tfplan

# Extraie la clé privée TLS avec Terraform et la copie dans le répertoire ~/.ssh/
terraform output -raw tls_private_key > ~/.ssh/id_rsa

# Change les permissions de la clé privée pour qu'elle soit accessible uniquement par l'utilisateur
chmod 600 ~/.ssh/id_rsa

# Récupère l'adresse IP publique à l'aide de la commande terraform output
PUBLIC_IP=$(terraform output public_ip_address)

# Copie le fichier ~/.ssh/config dans un fichier temporaire
cp ~/.ssh/config ~/.ssh/config.tmp

# Remplace ADRESSE_IP_PUBLIQUE par l'adresse IP publique dans le fichier temporaire
sed -i "s/ADRESSE_IP_PUBLIQUE/$PUBLIC_IP/g" ~/.ssh/config.tmp

# Remplace le fichier ~/.ssh/config par le fichier temporaire
mv ~/.ssh/config.tmp ~/.ssh/config

# Exécute le playbook Ansible
ansible-playbook -v playbook.yml