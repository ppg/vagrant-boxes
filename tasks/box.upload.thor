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
    sha = Digest::SHA1.hexdigest(IO.read(box))
    run "echo '#{sha}' > #{box}.sha1"
    run "rsync -avz --progress #{box} #{box}.sha1 #{options[:repo]}"
  end

end
