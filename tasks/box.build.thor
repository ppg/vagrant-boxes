class Box < Thor
  include Thor::Actions

  desc 'build [BOX]', 'Build, export, and add a box to Vagrant'

  method_option :prefix, :aliases => '-p', :default => 'sendgrid_', :desc => 'Prefix for exported boxes'
  method_option :version, :type => :boolean, :default => false, :desc => 'Append version to exported boxes'

  def build(box=nil)
    run "command -v rvm >/dev/null 2>&1"
    rvm_command = $?.success? ? 'rvm system do' : nil
    (box.nil? ? Dir.entries('definitions').reject { |obj| obj =~ /^\./ } : [box]).each do |b|
      run "veewee vbox build #{b} --force"
      if $?.success?
        b_final = "#{options[:prefix]}#{b}"
        b_final << ".#{Time.now.utc.strftime("%Y%m%d%H%M")}" if options[:version]
        File.delete("#{b_final}.box") if File.exists?("#{b_final}.box")
        run "#{rvm_command} vagrant package --base #{b} --output #{b_final}.box"
        run "#{rvm_command} vagrant box add #{b_final} #{b_final}.box --force"
      end
    end
  end

end
