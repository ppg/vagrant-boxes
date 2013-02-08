desc "Rebuild a basebox"
task :rebuild, :basebox do |t,args|
  (args.basebox.nil? ? Dir.entries('definitions').reject { |obj| obj =~ /^\./ } : [args.basebox]).each do |basebox|
    sh "bundle exec vagrant basebox build #{basebox} --force"
    sh "bundle exec vagrant basebox export #{basebox} --force"
    sh "bundle exec vagrant box add #{basebox} #{basebox}.box --force"
  end
end
