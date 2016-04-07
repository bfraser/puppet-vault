require 'spec_helper'

describe 'vault::service', :type => :class do
  context "On a Debian OS" do
    let :facts do
      {
        :osfamily               => 'Debian',
        :operatingsystemrelease => '7',
        :concat_basedir         => '/tmp',
        :lsbdistid              => 'Debian',
      }
    end

    context "vault running and enabled" do
      let (:params) {
        {
          :restart_cmd    => '/etc/init.d/vault restart', 
          :service_ensure => 'running', 
          :service_enable => true
        }
      }
      it { should contain_service("vault").with(
        'ensure'     => 'running',
        'enable'     => 'true',
        'hasstatus'  => 'true',
        'hasrestart' => 'true',
        'restart'    => '/etc/init.d/vault restart'
        )
      }
    end

    context "vault running and disabled" do
      let (:params) {
        {
          :restart_cmd    => '/etc/init.d/vault restart', 
          :service_ensure => 'running', 
          :service_enable => false
        }
      }
      it { should contain_service("vault").with(
        'ensure'     => 'running',
        'enable'     => 'false',
        'hasstatus'  => 'true',
        'hasrestart' => 'true',
        'restart'    => '/etc/init.d/vault restart'
        )
      }
    end

    context "vault stopped but enabled" do
      let (:params) {
        {
          :restart_cmd    => '/etc/init.d/vault restart', 
          :service_ensure => 'stopped', 
          :service_enable => true
        }
      }
      it { should contain_service("vault").with(
        'ensure'     => 'stopped',
        'enable'     => 'true',
        'hasstatus'  => 'true',
        'hasrestart' => 'true',
        'restart'    => '/etc/init.d/vault restart'
        )
      }
    end

    context "vault stopped and disabled" do
      let (:params) {
        {
          :restart_cmd    => '/etc/init.d/vault restart', 
          :service_ensure => 'stopped', 
          :service_enable => false
        }
      }
      it { should contain_service("vault").with(
        'ensure'     => 'stopped',
        'enable'     => 'false',
        'hasstatus'  => 'true',
        'hasrestart' => 'true',
        'restart'    => '/etc/init.d/vault restart'
        )
      }
    end
  end
end
