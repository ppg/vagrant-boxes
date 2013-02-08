desc "Rebuild a basebox"
task :rebuild, :basebox do |t,args|
  `vagrant basebox build #{args.basebox} --force`
  `vagrant basebox export #{args.basebox} --force`
  `vagrant box add #{args.basebox} #{args.basebox}.box --force`
end
