describe_recipe 'vagrant_base_box::vagrant' do

  it 'creates the vagrant user, group, and home directory' do
    user(node['vagrant_base_box']['vagrant']['user']).must_exist.with(:home, node['vagrant_base_box']['vagrant']['home'])
    group(node['vagrant_base_box']['vagrant']['user']).must_exist
    user(node['vagrant_base_box']['vagrant']['user']).must_exist.with(:gid, Etc.getgrnam(node['vagrant_base_box']['vagrant']['user']).gid)
    directory(node['vagrant_base_box']['vagrant']['home']).must_exist.with(:owner, node['vagrant_base_box']['vagrant']['user'])
  end

  it 'configures sudo for Vagrant' do
    ['exempt_group+=vagrant', 'env_keep+=SSH_AUTH_SOCK', '!requiretty', '(ALL) NOPASSWD: ALL'].each do |grep|
      assert_sh "sudo -l -U #{node['vagrant_base_box']['vagrant']['user']} | grep '#{grep}'"
    end
  end

  it "can log in with Vagrant's SSH keys" do
    assert_sh "ssh -i #{node['vagrant_base_box']['vagrant']['home']}/.ssh/id_rsa -o StrictHostKeyChecking=no -o PasswordAuthentication=no #{node['vagrant_base_box']['vagrant']['user']}@localhost 'echo success' | grep success"
  end

end
