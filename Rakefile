task :default => [:build]

desc "Build, export, and add a base box to Vagrant"
task :build, :basebox do |t,args|
  (args.basebox.nil? ? Dir.entries('definitions').reject { |obj| obj =~ /^\./ } : [args.basebox]).each do |basebox|
    sh "bundle exec vagrant basebox build #{basebox} --force"
    sh "bundle exec vagrant basebox export #{basebox} --force"
    sh "bundle exec vagrant box add #{basebox} #{basebox}.box --force"
  end
end
