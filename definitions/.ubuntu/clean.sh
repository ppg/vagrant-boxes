set -eux

# Remove unneeded packages
aptitude -y purge linux-headers-$(uname -r) build-essential

# Remove leftover leases and persistent rules
rm /etc/udev/rules.d/70-persistent-net.rules
mkdir /etc/udev/rules.d/70-persistent-net.rules
rm /lib/udev/rules.d/75-persistent-net-generator.rules
rm -rf /dev/.udev/ /var/lib/dhcp3/*

# Add a delay to interface up to make dhclient happy
echo "pre-up sleep 2" >> /etc/network/interfaces
