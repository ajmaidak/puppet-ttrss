require 'spec_helper'
describe 'ttrss', type: :class do
    let(:facts) {{ :osfamily => 'RedHat', :operatingsystem => 'Fedora' }}
    it { should compile }
end
