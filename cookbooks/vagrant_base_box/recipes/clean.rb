#
# Cookbook Name:: vagrant_base_box
# Recipe:: clean
#
# Copyright (C) 2014 SendGrid
#
# All rights reserved - Do Not Redistribute
#
if node['vagrant_base_box']['clean']['enable']
  node['vagrant_base_box']['virtualbox']['dependencies'].each do |name, _version|
    package name do
      action :remove
    end
  end

  file node['vagrant_base_box']['virtualbox']['guest_additions']['destination'] do
    action :delete
  end

  if node['platform'] == 'ubuntu'
    # Remove leftover leases and persistent rules
    %w(
      /etc/udev/rules.d/70-persistent-net.rules
      /lib/udev/rules.d/75-persistent-net-generator.rules
    ).each do |obj|
      file obj do
        action :delete
        only_if { ::File.file?(obj) }
      end
    end
    directory '/etc/udev/rules.d/70-persistent-net.rules' do
      mode 00755
    end
    execute 'rm -rf /dev/.udev/ /var/lib/dhcp3/*'

    # Add a delay to interface up to make dhclient happy
    execute 'echo "pre-up sleep 2" >> /etc/network/interfaces' do
      not_if "grep 'pre-up sleep 2' /etc/network/interfaces"
    end
  end

  # Zero out the free space to save space in the final image
  execute 'dd if=/dev/zero of=/EMPTY bs=1M || rm /EMPTY'
end
