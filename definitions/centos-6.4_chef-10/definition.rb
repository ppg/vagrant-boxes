require File.join(File.dirname(__FILE__), '..', '.centos', 'definition.rb')

iso = "CentOS-6.4-x86_64-bin-DVD1.iso"

Veewee::Session.declare(CENTOS_DEFINITION.merge({
  :iso_file => iso,
  :iso_md5 => "0128cfc7c86072b13ee80dd013e0e5d7",
  :iso_src => "http://mirrors.kernel.org/centos/6.4/isos/x86_64/#{iso}"
}))
