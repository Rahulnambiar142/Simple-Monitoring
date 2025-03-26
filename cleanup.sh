#!/bin/bash

echo "Stopping Netdata..."
systemctl stop netdata

echo "Uninstalling Netdata..."
/usr/libexec/netdata/netdata-uninstaller.sh --yes

if [[ $? -eq 0 ]]; then
  echo "Netdata uninstallation successful."
else
  echo "Netdata uninstallation failed."
  exit 1
fi

echo "Cleaning up configuration files..."
rm -rf /etc/netdata/

echo "Cleanup complete."
