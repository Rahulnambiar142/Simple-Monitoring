#!/bin/bash

echo "Installing Netdata..."
bash <(curl -Ss https://my-netdata.io/kickstart.sh)

if [[ $? -eq 0 ]]; then
  echo "Netdata installation successful."
else
  echo "Netdata installation failed."
  exit 1
fi

echo "Netdata dashboard should be accessible at http://$(hostname -I | awk '{print $1}'):19999"

# Example of adding a custom alert file.
echo "Adding CPU alert configuration..."
cat <<EOF > /etc/netdata/health.d/cpu.conf
template: cpu_usage
on: system.cpu
class: System
family: CPU
units: percentage
value: average
lookup: average -1m unaligned
warn: \$this > 80
crit: \$this > 90
EOF

echo "CPU alert configuration added."
systemctl restart netdata
echo "Netdata restarted to apply configuration changes."
