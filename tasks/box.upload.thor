class Box < Thor
  include Thor::Actions

  desc 'upload [BOX]', 'Upload a box to the repo'

  method_option :repo, :aliases => '-r', :default => 'root@repo.sendgrid.net:/var/www/repo/', :desc => 'Repo'

  def upload(box=nil)
    run "echo rsync -avz --progress #{box.nil? ? "*.box" : box} #{options[:repo]}"
  end

end
