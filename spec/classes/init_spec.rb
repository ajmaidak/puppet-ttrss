require 'spec_helper'
describe 'ttrss' do

  context 'with defaults for all parameters' do
    it { should contain_class('ttrss') }
  end
end
