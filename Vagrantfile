BOXES_PATH = File.expand_path(File.join('.vagrant.d', 'boxes'), Dir.home)

Vagrant.configure('2') do |config|
  Dir[File.join(BOXES_PATH, '*')].map { |obj| File.basename(obj) }.each do |box|

    box_name = "#{box}_default"
    config.vm.define box_name do |c|
      c.vm.box = box
      c.vm.host_name = "#{box_name.gsub(/[^a-z0-9\-]+/i, '-')}.test"
      c.ssh.forward_agent = true
    end

    box_name = "#{box}_devtools"
    config.vm.define box_name do |c|
      c.vm.box = box
      c.vm.host_name = "#{box_name.gsub(/[^a-z0-9\-]+/i, '-')}.test"
      c.ssh.forward_agent = true

      c.berkshelf.enabled = true
      c.vm.provision 'chef_solo' do |chef|
        chef.run_list = %w(
          sendgrid_minitest-handler
          sendgrid_rbenv::default_rubies
        )
      end
    end
  end
end
