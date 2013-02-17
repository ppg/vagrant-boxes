class Box < Thor
  include Thor::Actions

  desc 'build [BOX]', 'Build, export, and add a box to Vagrant'

  def build(box=nil)
    (box.nil? ? ::Dir.entries('definitions').reject { |obj| obj =~ /^\./ } : [box]).each do |b|
      run "bundle exec vagrant basebox build #{b} --force"
      run "bundle exec vagrant basebox export #{b} --force"
      version = ::Time.now.utc.strftime("%Y%m%d%H%M")
      ::File.rename("#{b}.box", "#{b}.#{version}.box")
      run "bundle exec vagrant box add #{b}.#{version} #{b}.#{version}.box --force"
    end
  end

end
