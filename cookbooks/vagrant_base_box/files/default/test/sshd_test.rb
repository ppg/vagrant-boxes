describe_recipe 'vagrant_base_box::sshd' do

  it 'disables the UseDNS option' do
    assert_sh("sshd -T | grep 'usedns no'")
  end

end
