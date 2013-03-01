Vagrant::Config.run do |config|
  Dir.entries(File.expand_path(File.join('~', '.vagrant.d', 'boxes'))).reject { |obj| obj =~ /^\./ }.each do |box|
    config.vm.define box do |c|
      c.vm.box = box
      c.vm.host_name = "#{box}.test"
      c.ssh.forward_agent = true
    end
  end
end
