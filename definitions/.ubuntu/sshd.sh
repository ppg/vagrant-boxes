set -eux

# Disable DNS lookups in sshd
printf "\nUseDNS no" >> /etc/ssh/sshd_config
service ssh restart
