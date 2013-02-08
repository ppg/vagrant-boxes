Vagrant::Config.run do |config|
  Dir.entries('definitions').reject { |obj| obj =~ /^\./ }.each do |vm|
    config.vm.define vm.to_sym do |c|
      c.vm.box = vm
      c.vm.host_name = "#{vm}.localdomain"
      c.ssh.forward_agent = true
    end
  end
end
