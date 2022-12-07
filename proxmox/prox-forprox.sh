#!/bin/bash

# IP du proxmox
PROXMOX_IP=YOUR_PROXMOX_IP

# si il y a 3 arguments
if [ $# -eq 3 ]
then
# on récupère les arguments
    VM_IP=$1
    DPORT=$2
    SPORT=$3
    # on crée les règle
    iptables -t nat -A PREROUTING -p tcp --dport $DPORT -j DNAT --to-destination $VM_IP:$SPORT
    iptables -t nat -A POSTROUTING -p tcp --sport $SPORT -s 10.1.18.12 -j SNAT --to-source $PROXMOX_IP:$DPORT

    # on sauvegarde les règles
    iptables-save > /etc/iptables/rules.v4

    # on affiche les règles
    iptables -t nat -L -n

# sinon on affiche l'aide
else
    echo "Usage: $0 VM_IP DPORT SPORT"
    echo "Example: $0 10.1.18.12 34 22"
fi 
