set -eux

# Install prerequisites for VirtualBox guest additions
yum -y install make gcc kernel-devel-$(uname -r)

# Install VirtualBox guest additions
VBOX_VERSION=$(cat /home/vagrant/.vbox_version)
mount -o loop VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
echo "yes" | sh /mnt/VBoxLinuxAdditions.run || true
umount /mnt
rm VBoxGuestAdditions_$VBOX_VERSION.iso
lsmod | grep -q vboxguest
