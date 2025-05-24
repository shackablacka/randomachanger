# random_mac_spoof

A simple Bash tool to change your MAC address to a random, valid, locally administered address. Great for testing network filtering or privacy tools.

## Usage

```bash
cd random_mac_spoof
chmod +x random_mac_spoof.sh
sudo ./random_mac_spoof.sh
```

## Note

Change the interface in the script (`IFACE="eth0"`) to your actual one, like `wlan0`.
