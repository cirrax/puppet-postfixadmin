require 'spec_helper'


describe 'postfixadmin::vhost' do
  let :facts do
    {
      :operatingsystemrelease => 'test',
      :osfamily               => 'Debian',
      :operatingsystem        => 'Debian',
      :lsbdistcodename        => 'Debian',
    }
  end

  # TODO: this needs fix !!
  #it { is_expected.to compile.with_all_deps }
end

