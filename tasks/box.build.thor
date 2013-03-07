class Box < Thor
  include Thor::Actions

  desc 'build [BOX]', 'Build, export, and add a box to Vagrant'

  method_option :prefix, :aliases => '-p', :default => 'sendgrid_', :desc => 'Prefix for exported boxes'
  method_option :version, :type => :boolean, :default => false, :desc => 'Append version to exported boxes'

  def build(box=nil)
    (box.nil? ? Dir.entries('definitions').reject { |obj| obj =~ /^\./ } : [box]).each do |b|
      run "vagrant basebox build #{b} --force"
      if $?.success?
        run "vagrant basebox export #{b} --force"
        b_final = "#{options[:prefix]}#{b}"
        b_final << ".#{Time.now.utc.strftime("%Y%m%d%H%M")}" if options[:version]
        File.rename("#{b}.box", "#{b_final}.box")
        run "vagrant box add #{b_final} #{b_final}.box --force"
      end
    end
  end

end
