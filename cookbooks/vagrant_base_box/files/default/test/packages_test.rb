describe_recipe 'vagrant_base_box::packages' do

  it 'installs the appropriate packages' do
    node['vagrant_base_box']['packages']['install'].each do |obj|
      package(obj).must_be_installed
    end
  end

end
