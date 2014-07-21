#
# Cookbook Name:: vagrant_base_box
# Recipe:: vagrant
#
# Copyright (C) 2014 SendGrid
#
# All rights reserved - Do Not Redistribute
#
user node['vagrant_base_box']['vagrant']['user'] do
  home node['vagrant_base_box']['vagrant']['home']
  password node['vagrant_base_box']['vagrant']['password']
  supports manage_home: true if node['platform'] == 'ubuntu'
end

template '/etc/sudoers.d/vagrant' do
  source 'vagrant.sudoers.erb'
  mode 00440
end

directory "#{node['vagrant_base_box']['vagrant']['home']}/.ssh" do
  owner node['vagrant_base_box']['vagrant']['user']
  group node['vagrant_base_box']['vagrant']['user']
  mode 00700
end

remote_file "#{node['vagrant_base_box']['vagrant']['home']}/.ssh/id_rsa" do
  owner node['vagrant_base_box']['vagrant']['user']
  group node['vagrant_base_box']['vagrant']['user']
  mode 00600
  source 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant'
  # curl -s https://raw.github.com/mitchellh/vagrant/master/keys/vagrant | gsha256sum
  checksum 'c95842bf221d67a85a26796ba13fb58951985bffc01f399fa0d133b89fa08a52'
end

remote_file "#{node['vagrant_base_box']['vagrant']['home']}/.ssh/authorized_keys" do
  owner node['vagrant_base_box']['vagrant']['user']
  group node['vagrant_base_box']['vagrant']['user']
  mode 00600
  source 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub'
  # curl -s https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub | gsha256sum
  checksum '9aa9292172c915821e29bcbf5ff42d4940f59d6a148153c76ad638f5f4c6cd8b'
end
