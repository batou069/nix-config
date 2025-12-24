#!/bin/sh
set -e

echo "Detected disk setup. Mounting partitions..."

# Root
sudo mount -o subvol=@,compress=zstd,noatime /dev/disk/by-uuid/0ee40fbe-c684-46ba-a921-46cdc7b5eb4a /mnt
echo "Mounted /"

# Home
sudo mkdir -p /mnt/home
sudo mount -o subvol=@home,compress=zstd,noatime /dev/disk/by-uuid/0ee40fbe-c684-46ba-a921-46cdc7b5eb4a /mnt/home
echo "Mounted /home"

# /var/log
sudo mkdir -p /mnt/var/log
sudo mount -o subvol=@log,compress=zstd,noatime /dev/disk/by-uuid/0ee40fbe-c684-46ba-a921-46cdc7b5eb4a /mnt/var/log
echo "Mounted /var/log"

# /srv
sudo mkdir -p /mnt/srv
sudo mount -o subvol=@/srv,compress=zstd,noatime /dev/disk/by-uuid/0ee40fbe-c684-46ba-a921-46cdc7b5eb4a /mnt/srv
echo "Mounted /srv"

# /tmp
sudo mkdir -p /mnt/tmp
sudo mount -o subvol=@/tmp,compress=zstd,noatime /dev/disk/by-uuid/0ee40fbe-c684-46ba-a921-46cdc7b5eb4a /mnt/tmp
echo "Mounted /tmp"

# /var/tmp
sudo mkdir -p /mnt/var/tmp
sudo mount -o subvol=@/var/tmp,compress=zstd,noatime /dev/disk/by-uuid/0ee40fbe-c684-46ba-a921-46cdc7b5eb4a /mnt/var/tmp
echo "Mounted /var/tmp"

# Boot
sudo mkdir -p /mnt/boot
sudo mount /dev/disk/by-uuid/E6E7-3376 /mnt/boot
echo "Mounted /boot"

echo "Mounting complete. You can now run:"
echo "sudo nixos-install --flake .#viech"
