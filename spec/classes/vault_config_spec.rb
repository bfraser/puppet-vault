require 'spec_helper'

describe 'vault::config', :type => :class do
  context "On a Debian OS" do
    let :facts do
      {
        :osfamily               => 'Debian',
        :operatingsystemrelease => '7',
        :concat_basedir         => '/tmp',
        :lsbdistid              => 'Debian',
      }

    end

    context "user and group exist for vault if manage users is set to true" do
      let (:params) {
        {
          :vault_user  => 'vault',
          :manage_user => true
        }
      }

      it { should contain_group('vault').with_ensure('present') }

      it { should contain_user('vault').with(
        'ensure'  => 'present',
        'gid'     => 'vault'
      ) }
    end

    context "vault init should be created" do
      it { should contain_file('/etc/init.d/vault').with(
        'ensure' => 'file',
        'mode'   => '0755',
        'owner'  => 'root',
        'group'  => 'root',
      ) }
    end

    context "vault config dir" do
      it { should contain_file('/etc/vault').with(
        'ensure'  => 'directory',
        'mode'    => '0755',
        'owner'   => 'root',
        'group'   => 'root',
        'purge'   => true,
        'recurse' => true
      ) }
    end

    context "vault config file" do
      let (:params) {{:vault_user => 'vault'}}
      it { should contain_file('/etc/vault/vault.json').with(
        'ensure'  => 'file',
        'mode'    => '0644',
        'owner'   => 'vault',
        'group'   => 'vault',
      ).that_requires(
        'File[/etc/vault]'
      ).that_requires(
        'File[/etc/init.d/vault]'
      ) }
    end

  end
end
