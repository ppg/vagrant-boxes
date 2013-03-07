BOXES_PATH = File.expand_path(File.join('.vagrant.d', 'boxes'), Dir.home)

Vagrant::Config.run do |config|
  Dir[File.join(BOXES_PATH, '*')].map { |obj| File.basename(obj) }.each do |box|
    config.vm.define box do |c|
      c.vm.box = box
      c.vm.host_name = "#{box.gsub(/[^a-z0-9\-]+/i, '-')}.test"
      c.ssh.forward_agent = true
    end
  end
end
