class Box < Thor
  include Thor::Actions

  desc 'upload [BOX]', 'Upload a box (and all box metadata) to the repository'

  method_option :repository, :aliases => '-r', :default => 'root@repo.sjc1.sendgrid.net:/srv/images/vagrant/', :desc => 'Repository'

  def upload(box=nil)
    if box.nil?
      Dir['*.box'].each do |b|
        rsync(b)
      end
    else
      rsync(box)
    end
  end

  private

  def rsync(box)
    run "rsync -avz --progress #{box} metadata #{options[:repository]}"
  end

end
