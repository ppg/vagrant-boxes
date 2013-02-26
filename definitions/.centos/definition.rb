require File.join(File.dirname(__FILE__), '..', '.common', 'definition.rb')

CENTOS_DEFINITION = COMMON_DEFINITION.merge({
  :memory_size => "480",
  :boot_cmd_sequence => %w{
    <Tab>
    text
    ks=http://%IP%:%PORT%/ks.cfg
    <Enter>
  }.map { |obj| "#{obj} " },
  :os_type_id => 'RedHat_64',
  :postinstall_files => %w{
    vbox.sh
    vagrant.sh
    sshd.sh
    chef.sh
    clean.sh
    minimize.sh
  },
  :kickstart_file => "ks.cfg",
  :shutdown_cmd => "/sbin/halt -h -p"
})
