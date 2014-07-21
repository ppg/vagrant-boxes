describe_recipe 'vagrant_base_box::clean' do

  it 'removes the virtualbox dependencies' do
    skip unless node['vagrant_base_box']['clean']['enable']
    node['vagrant_base_box']['virtualbox']['dependencies'].each do |name, _version|
      package(name).wont_be_installed
    end
  end

  it 'removes the guest additions ISO' do
    skip unless node['vagrant_base_box']['clean']['enable']
    file(node['vagrant_base_box']['virtualbox']['guest_additions']['destination']).wont_exist
  end

end
