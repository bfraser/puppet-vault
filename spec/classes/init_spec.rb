require 'spec_helper'

  describe 'vault' do
    context 'with defaults for all parameters' do
      it { should compile.with_all_deps }

      let(:facts) {
        {
          osfamily: 'Debian',
          operatingsystem: 'Debian',
          lsbdistcodename: 'wheezy',
          manage_user: true,
        }
      }

      it { should contain_class('vault') }

    end

    context 'installs and configure vault' do
      let(:facts) {
        {
          osfamily: 'Debian',
          operatingsystem: 'Debian',
          lsbdistcodename: 'wheezy',
          manage_user: true,
        }
      }

      let (:params) {
        {
          :package_ensure => 'present',
          :vault_user     => 'vault',
          :version        => '0.5.2'
        }
      }

      it { is_expected.to contain_class('vault::install') }
      it { is_expected.to contain_class('vault::config') }
      it { is_expected.to contain_class('vault::service') }

    end

    context 'uninstall vault from the system' do
      let(:facts) {
        {
          osfamily: 'Debian',
          operatingsystem: 'Debian',
          lsbdistcodename: 'wheezy',
          manage_user: true,
        }
      }

      let (:params) {
        {
          :package_ensure => 'absent',
          :vault_user     => 'vault',
          :version        => '0.5.2'
        }
      }

      it { is_expected.to contain_class('vault::install') }

    end

end
