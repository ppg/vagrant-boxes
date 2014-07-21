class Box < Thor
  include Thor::Actions

  desc 'devtools <BOX>', 'Create a devtools box'

  def devtools(box)
    box = "#{box}_devtools"
    [
      "vagrant up #{box}",
      "vagrant package #{box} --output #{box}-$(date +%s).box"
    ].each do |cmd|
      run cmd
    end
  end
end
