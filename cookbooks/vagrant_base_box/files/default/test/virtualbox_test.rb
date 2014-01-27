describe_recipe 'vagrant_base_box::virtualbox' do

  it 'finds the kernel headers when installing the vboxguest kernel module' do
    assert_sh('grep -v KERN_DIR /var/log/vboxadd-install.log')
  end

  it 'loads the vboxguest kernel module' do
    assert_sh('lsmod | grep -q vboxguest')
  end

end
