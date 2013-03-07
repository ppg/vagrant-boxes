require File.join(File.dirname(__FILE__), '..', '.common', 'definition.rb')

UBUNTU_DEFINITION = COMMON_DEFINITION.merge({
  :boot_cmd_sequence => %w{
    <Esc>
    <Esc>
    <Enter>
    /install/vmlinuz
    auto
    console-setup/ask_detect=false
    console-setup/layoutcode=us
    console-setup/modelcode=pc105
    debconf/frontend=noninteractive
    debian-installer=en_US
    domain=vagrantup.com
    fb=false
    hostname=vagrant-ubuntu
    initrd=/install/initrd.gz
    kbd-chooser/method=us
    keyboard-configuration/layout=USA
    keyboard-configuration/variant=USA
    locale=en_US
    noapic
    preseed/url=http://%IP%:%PORT%/preseed.cfg
   --
   <Enter>
  }.map { |obj| "#{obj} " },
  :os_type_id => 'Ubuntu_64',
  :postinstall_files => %w{
    vbox.sh
    vagrant.sh
    sudo.sh
    sshd.sh
    chef.sh
    clean.sh
    minimize.sh
  },
  :kickstart_file => "preseed.cfg",
  :shutdown_cmd => "shutdown -P now"
})
