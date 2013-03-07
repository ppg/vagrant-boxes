require File.join(File.dirname(__FILE__), '..', '.centos', 'definition.rb')

iso = "CentOS-6.3-x86_64-bin-DVD1.iso"

Veewee::Session.declare(CENTOS_DEFINITION.merge({
  :iso_file => iso,
  :iso_md5 => "a991defc0a602d04f064c43290df0131",
  :iso_src => "http://mirrors.kernel.org/centos/6.3/isos/x86_64/#{iso}"
}))
