#
# Cookbook Name:: vagrant_base_box
# Recipe:: sshd
#
# Copyright (C) 2014 SendGrid
#
# All rights reserved - Do Not Redistribute
#
sshd_service = case node['platform']
when 'centos'
  'sshd'
when 'ubuntu'
  'ssh'
end

service sshd_service do
  action :nothing
end

execute 'printf "\nUseDNS no" >> /etc/ssh/sshd_config' do
  not_if "grep 'UseDNS no' /etc/ssh/sshd_config"
  notifies :restart, "service[#{sshd_service}]"
end
