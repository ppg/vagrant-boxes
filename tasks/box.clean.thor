class Box < Thor

  desc 'clean', 'Remove old boxes'

  def clean
    ::Dir['*.box'].each { |f| ::File.delete(f) }
  end

end
