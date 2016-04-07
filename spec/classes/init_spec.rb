require 'spec_helper'

  describe 'vault' do
    context 'with defaults for all parameters' do
      it { should compile.with_all_deps }

      let(:facts) do
    {
      osfamily: 'Debian',
      operatingsystem: 'Debian',
      lsbdistcodename: 'wheezy',
      manage_user: true,
    }
  end

  it { should contain_class('vault') }

  end

end
