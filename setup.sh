#!/bin/bash

# setup.sh - installs Netdata on a Linux system

set -e

echo "[*] Installing Netdata monitoring agent..."
bash <(curl -L -Ss https://my-netdata.io/kickstart.sh) --dont-wait

echo "[*] Allowing access to port 19999 (Netdata Web UI)..."
if command -v ufw &>/dev/null; then
    sudo ufw allow 19999/tcp
elif command -v firewall-cmd &>/dev/null; then
    sudo firewall-cmd --permanent --add-port=19999/tcp
    sudo firewall-cmd --reload
else
    echo "[!] Firewall not detected or not supported by script."
fi

echo "[*] Setting custom CPU usage alert..."
cat <<EOF | sudo tee /etc/netdata/health.d/cpu_usage.conf > /dev/null
alarm: high_cpu_usage
on: system.cpu
lookup: average -1m unaligned
units: %
every: 10s
warn: $this > 20
crit: $this > 40
delay: down 10s
repeat: 1m
info: CPU usage is high
EOF

sudo systemctl restart netdata

echo "[*] Netdata installed and running. Access the dashboard at: http://<your-server-ip>:19999"

