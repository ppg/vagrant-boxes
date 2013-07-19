set -eux

# Configure sudo for Vagrant
cat << 'EOF' > /etc/sudoers.d/vagrant
Defaults exempt_group += vagrant
Defaults env_keep += SSH_AUTH_SOCK
Defaults !requiretty
vagrant ALL=(ALL) NOPASSWD: ALL
EOF
chmod 0440 /etc/sudoers.d/vagrant
