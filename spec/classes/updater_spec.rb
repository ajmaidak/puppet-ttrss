require 'spec_helper'
describe 'ttrss::updater', type: :class do
    let(:facts) {{ :osfamily => 'Debian' }}
    it { should compile }
    it { is_expected.to contain_file('/etc/systemd/system/ttrss-update.service') }
end
