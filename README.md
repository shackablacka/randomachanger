# randomac

A simple Bash tool to change your MAC address to a random, valid, locally administered address. Great for testing network filtering or privacy tools.

## Usage

```bash
git clone https://github.com/shackablacka/randomachanger.git
cd randomachanger
chmod +x randomac.sh
sudo ./randomac.sh
```

## Note

Change the interface in the script (`IFACE="eth0"`) to your actual one, like `wlan0`.
