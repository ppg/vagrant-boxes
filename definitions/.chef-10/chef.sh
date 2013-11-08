set -eux

# Install Chef client
wget -O - http://opscode.com/chef/install.sh | bash -s -- -v 10.28.2
