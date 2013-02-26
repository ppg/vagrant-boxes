set -eux

# Remove unneeded packages
yum -y remove make gcc kernel-devel-$(uname -r)
