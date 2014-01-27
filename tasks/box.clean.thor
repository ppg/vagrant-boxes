class Box < Thor
  include Thor::Actions

  desc 'clean', 'Remove old artifacts'

  def clean
    run 'rm *.box'
    run 'rm *.sha1'
  end

end
