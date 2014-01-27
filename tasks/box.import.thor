class Box < Thor
  include Thor::Actions

  desc 'import [BOX]', 'Import boxes into Vagrant'

  def import(box=nil)
    if box.nil?
      Dir['*.box'].each do |b|
        vagrant_box_add(b)
      end
    else
      vagrant_box_add(box)
    end
  end

  private

  def vagrant_box_add(box)
    run "vagrant box add #{File.basename(box, File.extname(box))} #{box} --force"
  end

end
