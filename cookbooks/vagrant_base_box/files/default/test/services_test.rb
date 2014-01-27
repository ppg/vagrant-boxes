describe_recipe 'vagrant_base_box::services' do

  it 'stops and disables the appropriate services' do
    node['vagrant_base_box']['services']['disable'].each do |obj|
      service(obj).wont_be_running
      service(obj).wont_be_enabled
    end
  end

end
