class Box < Thor
  include Thor::Actions

  desc 'export <BOX>', 'Mutate and export a box for the specified provider'

  method_option :input_provider, :aliases => '-i', :default => 'virtualbox', :desc => 'Input provider'
  method_option :output_provider, :aliases => '-o', :default => 'libvirt', :desc => 'Output provider'

  def export(box)
    run "vagrant mutate --input_provider=#{options[:input_provider]} #{box} #{options[:output_provider]}"
    run "vagrant box repackage #{box} #{options[:output_provider]} 0"
    run "mv package.box #{box}.#{options[:output_provider]}.box"
  end

end
