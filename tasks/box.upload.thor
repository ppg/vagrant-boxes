require 'digest/sha1'

class Box < Thor
  include Thor::Actions

  desc 'upload [BOX]', 'Upload a box (and SHA-1 checksum) to the repo'

  method_option :repo, :aliases => '-r', :default => 'root@repo.sendgrid.net:/var/www/repo/', :desc => 'Repo'

  def upload(box=nil)
    if box.nil?
      Dir['*.box'].each do |b|
        sum_and_upload(b)
      end
    else
      sum_and_upload(box)
    end
  end

  private

  def sum_and_upload(box)
    # Note: We sha1sum the imported disk (not the box itself) because it's the
    # only reasonable thing to compare against once a box is installed. This is
    # used by the tests at: https://github.com/sendgrid-ops/workstation_setup
    sha_path = File.join(Dir.home, '.vagrant.d', 'boxes', File.basename(box, '.box'), 'virtualbox', 'box-disk1.vmdk')
    sha = Digest::SHA1.hexdigest(IO.read(sha_path))
    run "echo '#{sha}' > #{box}.sha1"
    run "rsync -avz --progress #{box} #{box}.sha1 #{options[:repo]}"
  end

end
