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

%w{
  virtualbox
  vagrant
  sshd
  clean
}.each do |obj|
  include_recipe "vagrant_base_box::#{obj}"
end
