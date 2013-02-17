class Box < Thor
  include Thor::Actions

  desc 'list', 'List available boxes'

  def list
    run "bundle exec vagrant basebox list"
  end

end
