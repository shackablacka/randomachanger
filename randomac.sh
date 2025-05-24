#!/bin/bash
# Random MAC address changer for lab testing

IFACE="eth0"  

generate_random_mac() {
  hexchars="0123456789ABCDEFGH"
  echo "02$(for i in {1..5}; do echo -n ${hexchars:$((RANDOM % 16)):1}${hexchars:$((RANDOM % 16)):1}; done | sed 's/../:&/g')"
}

RANDOM_MAC=$(generate_random_mac)
echo "[*] Generated random MAC: $RANDOM_MAC"

sudo ip link set $IFACE down
sudo ip link set $IFACE address $RANDOM_MAC
sudo ip link set $IFACE up

ip link show $IFACE | grep ether
