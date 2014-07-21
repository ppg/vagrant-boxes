#
# Cookbook Name:: vagrant_base_box
# Recipe:: default
#
# Copyright (C) 2014 SendGrid
#
# All rights reserved - Do Not Redistribute
#
execute 'aptitude update' do
  only_if { node['platform'] == 'ubuntu' }
end

if node['platform'] == 'centos'
  service 'networking' do
    action :nothing
  end

  template '/etc/sysconfig/network' do
    variables(
      hostname: node['fqdn']
    )
    mode 00644
    notifies :restart, 'service[networking]'
  end
end

%w(
  packages
  virtualbox
  vagrant
  sshd
  services
  clean
).each do |obj|
  include_recipe "vagrant_base_box::#{obj}"
end
