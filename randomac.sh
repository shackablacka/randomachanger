#!/bin/bash
# randomac.sh - Change MAC address 

IFACE="${1:-eth0}"  # Default interface is eth0, or use argument
LOGFILE="/var/log/mac_spoof.log"

generate_random_mac() {
  hexchars="0123456789ABCDEFGH"
  echo "02$(for i in {1..5}; do
    echo -n ${hexchars:$((RANDOM % 16)):1}${hexchars:$((RANDOM % 16)):1}
  done | sed 's/../:&/g')"
}

# Ensure the log file exists and is writable
sudo touch "$LOGFILE"
sudo chown "$USER" "$LOGFILE"

RANDOM_MAC=$(generate_random_mac)
TIMESTAMP="$(date '+%Y-%m-%d %H:%M:%S')"

{
  echo
  echo "=== $TIMESTAMP ==="
  echo "[*] Target interface: $IFACE"
  echo "[*] Generated MAC: $RANDOM_MAC"

  if ! ip link show "$IFACE" &>/dev/null; then
    echo "[!] Interface $IFACE not found. Exiting."
    exit 1
  fi

  echo "[*] Bringing down $IFACE..."
  sudo ip link set "$IFACE" down || exit 1

  echo "[*] Setting new MAC..."
  sudo ip link set "$IFACE" address "$RANDOM_MAC" || exit 1

  echo "[*] Bringing up $IFACE..."
  sudo ip link set "$IFACE" up || exit 1

  echo "[+] MAC address changed to:"
  ip link show "$IFACE" | grep ether
} | tee -a "$LOGFILE"
