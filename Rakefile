task :default => [:build]

desc "Build, export, and add a base box to Vagrant"
task :build, :basebox do |t,args|
  (args.basebox.nil? ? Dir.entries('definitions').reject { |obj| obj =~ /^\./ } : [args.basebox]).each do |basebox|
    sh "bundle exec vagrant basebox build #{basebox} --force"
    sh "bundle exec vagrant basebox export #{basebox} --force"
    version = Time.now.utc.strftime("%Y%m%d%H%M")
    File.rename("#{basebox}.box", "#{basebox}.#{version}.box")
    sh "bundle exec vagrant box add #{basebox} #{basebox}.#{version}.box --force"
  end
end

desc "Upload a base box to the repo"
task :upload, :basebox do |t,args|
  sh "rsync -avz --progress #{args.basebox.nil? ? "*.box" : args.basebox} root@repo.sendgrid.net:/var/www/repo/"
end

desc "Remove old files"
task :clean do
  Dir['*.box'].each { |f| File.delete(f) }
end
