set -eux

# Configure sudo for Vagrant
sed -i -e '/Defaults\s\+env_reset/a Defaults\texempt_group=admin' /etc/sudoers
sed -i -e '/Defaults\s\+exempt_group/a Defaults\tenv_keep += "SSH_AUTH_SOCK"' /etc/sudoers
sed -i -e 's/^%admin.*$/%admin ALL=NOPASSWD: ALL/' /etc/sudoers
