require 'spec_helper'

describe 'vault::install', :type => :class do
  context "On a Debian OS" do
    let :facts do
      {
        :osfamily               => 'Debian',
        :operatingsystemrelease => '7',
        :concat_basedir         => '/tmp',
        :lsbdistid              => 'Debian',
      }

    end

    context "install vault when version is set" do
      let (:params) {
        {
          :package_ensure => 'present', 
          :version        => '0.5.2', 
        }
      }
      it { should contain_package('vault').with(
        'ensure'   => '0.5.2',
        'provider' => 'aptitude'
      ) }
    end

    context "uninstall vault when package_ensure is set to absent" do
      let (:params) {
        {
          :package_ensure => 'absent',
          :vault_user     => 'vault'
        }
      }

      it { should contain_package('vault').with(
        'ensure' => 'purged'
      ) }
    end

    context "remove vault group" do
      let (:params) {
        {
          :package_ensure => 'absent',
          :vault_user     => 'vault'
        }
      }

      it { should contain_group('vault').with(
        'ensure' => 'absent'
      ) }
    end

    context "remove vault user" do
      let (:params) {
        {
          :package_ensure => 'absent',
          :vault_user     => 'vault'
        }
      }

      it { should contain_user('vault').with(
        'ensure' => 'absent'
      ) }
    end

    context "remove vault init script" do
      let (:params) {
        {
          :package_ensure => 'absent',
          :vault_user     => 'vault'
        }
      }

      it { should contain_file('/etc/init.d/vault').with(
        'ensure' => 'absent'
      ) }
    end

    context "remove vault config directory" do
      let (:params) {
        {
          :package_ensure => 'absent',
          :vault_user     => 'vault'
        }
      }

      it { should contain_file('/etc/vault').with(
        'ensure' => 'absent'
      ) }
    end


  end
end
