describe_recipe 'vagrant_base_box::default' do

  it 'Sets the single-request-reopen option in resolv.conf' do
    skip unless node['platform'] == 'centos'
    assert_sh('grep options /etc/resolv.conf | grep single-request-reopen')
  end

end
