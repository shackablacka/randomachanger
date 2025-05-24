#!/bin/bash
# random_mac_spoof.sh - Random MAC address changer for privacy 

IFACE="${1:-eth0}"  # Allow interface as argument; default to eth0

# Generate a locally administered, unicast MAC address
generate_random_mac() {
  hexchars="0123456789ABCDEF"
  echo "02$(for i in {1..5}; do echo -n ${hexchars:$((RANDOM % 16)):1}${hexchars:$((RANDOM % 16)):1}; done | sed 's/../:&/g')"
}

RANDOM_MAC=$(generate_random_mac)

echo "[*] Target interface: $IFACE"
echo "[*] Generated random MAC: $RANDOM_MAC"

# Validate interface exists
if ! ip link show "$IFACE" &> /dev/null; then
  echo "[!] Interface $IFACE not found. Exiting."
  exit 1
fi

echo "[*] Bringing down interface $IFACE..."
sudo ip link set "$IFACE" down || exit 1

echo "[*] Changing MAC address..."
sudo ip link set "$IFACE" address "$RANDOM_MAC" || exit 1

echo "[*] Bringing up interface $IFACE..."
sudo ip link set "$IFACE" up || exit 1

echo "[+] MAC address successfully changed to:"
ip link show "$IFACE" | grep ether
 echo "[*] Sleeping for 10 minutes..."
  sleep 600
done
