require 'spec_helper'


describe 'postfixadmin::vhost::apache' do
  let :pre_condition do
    'class { "apache": mpm_module => "prefork" }'
  end

  let :facts do
    {
      :operatingsystemrelease => 'test',
      :osfamily               => 'Debian',
      :operatingsystem        => 'Debian',
      :lsbdistcodename        => 'Debian',
    }
  end

  it { is_expected.to compile.with_all_deps }
end

