#!/bin/bash

set -e

if ! command -v zramctl &>/dev/null; then
  echo "Installing zram-generator..."
  sudo pacman -Sy --noconfirm zram-generator
fi

echo "Configuring zram-generator..."
sudo tee /etc/systemd/zram-generator.conf >/dev/null <<EOF
[zram0]
zram-size = ram / 4
EOF

sudo systemctl daemon-reload

sudo systemctl start /dev/zram0

echo "Verifying zram device..."
sudo zramctl
sudo swapon --show
